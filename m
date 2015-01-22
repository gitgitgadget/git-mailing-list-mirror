From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Thu, 22 Jan 2015 18:17:16 +0100
Organization: gmx
Message-ID: <595afdd37f7774361bc18de8003c2d16@www.dscho.org>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
 <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
 <xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
 <xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
 <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
 <xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
 <xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
 <54C11C0B.6080200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tanay Abhra <tanayabh@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YELNm-0001V4-3y
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 18:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbbAVRRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 12:17:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:53775 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbbAVRRV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 12:17:21 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Md31i-1XxMlD13gI-00IB27; Thu, 22 Jan 2015 18:17:17
 +0100
In-Reply-To: <54C11C0B.6080200@alum.mit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:bPhr0GZVEGG+Y9a15AhGVN9xh6CxfPoTf5iWDCHxf6OoYpy9KbB
 PIQLZjnzcrQFmDWYP9zbhSuUSRONg/DDnXW8CfZ8pn61RzpLqQqpcHecLOwD+2ZGqnvKSNI
 pkRLEVqkXvsdAvFCvYNxcWNa7mRpyC2tMvGpfJWmz/gJYVPyR8Tef3j9GeBjV43BGN9svLp
 DvXoPHGy3Yout5OS96r4g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262847>

Hi Michael,

On 2015-01-22 16:49, Michael Haggerty wrote:
> On 12/23/2014 06:14 PM, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> On Tue, 23 Dec 2014, Junio C Hamano wrote:
>>>> I suspect that it would be much better if the configuration variables
>>>> were organized the other way around, e.g.
>>>>
>>>> 	$ git config fsck.warn missingTagger,someOtherKindOfError
>>>
>>> I had something similar in an earlier version of my patch series, but it
>>> was shot down rightfully: if you want to allow inheriting defaults from
>>> $HOME/.gitconfig, you have to configure the severity levels individually.
>>
>> Hmmm.  What's wrong with "fsck.warn -missingTagger" that overrides
>> the earlier one, or even "fsck.info missingTagger" after having
>> "fsck.warn other,missingTagger,yetanother", with the usual "last one
>> wins" rule?
>>
>> Whoever shot it down "rightfully" is wrong here, I would think.
> 
> Sorry I didn't notice this earlier; Johannes, please CC me on these
> series, especially the ones that I commented on earlier.

Very sorry, this is my fault. It can only be explained by my switching around some tools for other tools to work with email-based patch submission (which I had not done in a long time). But still, my mistake.


> [1] I prefer to think that I just offered a little gentle discussion
> that informed Johannes's independent decision :-)

You did convince me back then. I just did not want to put up a fight against Junio because I was more interested in getting this feature merged before the holidays (it does feel awkward for me to leave work unwrapped-up before leaving for an extended amount of time, but I guess I am getting more used to that).

So now I cannot avoid discussing this issue properly...

In essence, I agreed with Junio from the point of view of an elegant implementation. But then, Michael is correct that it does not really matter as much how complicated the code is, but that it is much more important that the feature is elegant to use.

Now let's step back a bit and think about the users which is supposed to be supported by this patch series: Git repository hosters -- such as GitHub -- need to ensure a certain cleanliness of the repositories they host (for a range of reasons, including the prevention of malicious attacks, or helping users publish their code in a correct form).

And the scenario in which the feature needs to be used is most likely started by some Git user pushing some commits, and `git receive-pack` triggering an error. Then the user files a trouble ticket and GitHubber needs to inspect the error and the respective object. Now, in the vast number of cases I imagine that the objects *are* faulty. However, on occasion the problem should not prevent the push, e.g. when somebody crafted a commit object with two authors, forgetting that the tools usually cannot handle such commits. Then the GitHubber has to decide on a case by case basis whether to demote that error to a warning and allow the object to be pushed *into that specific repository*.

I do see the need for this feature to be simple and robust, from the users' point of view. In other words, I agree with Michael that we need to avoid confusing settings such as

```
[receive.fsck]
    warn = missing-tagger-entry
    error = missing-tagger-entry
```

This feature will be used rarely enough that the poor soul stuck with interpreting the above config section won't remember that a very specific version of "last setting wins" is in effect.

If I remember correctly, Peff suggested that there needs to be a way to handle these settings in the /etc/gitconfig $HOME/.gitconfig $XDG../gitconfig .git/config cascade, but now I am puzzled whether it is even desirable to demote fsck errors globally, i.e. whether we really need to pay attention to that config cascade.

And finally, in the course of preparing this patch series, we came up with an alternative solution to the problem: the receive.fsck.skiplist (i.e. a file that contains a sorted list of SHA-1s of objects that should be skipped from fsck'ing). I am more and more convinced that this is the most convenient tool for the scenario described above: manual inspection of individual objects will tell whether it is safe to allow them onto the server or not.

However, others might disagree and prefer the explicit approach, e.g. when some source generates a consistent stream of objects triggering fsck errors.

Summary: I have no preference how to specify the severity levels of fsck messages, but I will gladly change my code to whatever you (meaning Junio and Michael in particular) want to see implemented.

Thanks for helping me with this feature,
Dscho
