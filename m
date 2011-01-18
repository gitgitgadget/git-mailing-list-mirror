From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Tue, 18 Jan 2011 10:04:29 +0100
Message-ID: <AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
	<AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
	<54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Aaron S. Meurer" <asmeurer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 10:04:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf7Ub-0000C3-Bp
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 10:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab1ARJEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 04:04:39 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32964 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1ARJEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jan 2011 04:04:36 -0500
Received: by wwa36 with SMTP id 36so6238003wwa.1
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 01:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=seWAktS/FGKaxnLLeQSzcQcoMmBmqmGd6bwdCDzyBFU=;
        b=nP/ex4BgmFSMXZXMDiOH76j7fQjhR/w//JhAG/ASLALr940scjVxMJZd9+OFke5sVE
         DImYvqEcLpCDXodICgYRFuuLh+qx7RZ71/km1XnCvhjrTg9pITCu9FNjggvNC4WsCNpz
         5vHd0vp3QdbW+zNmz4LvlDLd99flpZQa3MY0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ASXNYEXpOQvIC4Z63gxrqkaxiwhxaFJBJRQlEwwH9OQMB6zj9Oa1FGT1RSxDGwH3Q6
         E/B+ZArsRWzLV41ObGY3gmfVJAfrTeffCiXu3qMiwdQ5nEiw2GclZJrYtEVwEYLK1HRB
         ipw3Mqkt3POIbTTzmPcOYod+nAAThamM5WfWM=
Received: by 10.216.179.81 with SMTP id g59mr862558wem.35.1295341469654; Tue,
 18 Jan 2011 01:04:29 -0800 (PST)
Received: by 10.216.50.129 with HTTP; Tue, 18 Jan 2011 01:04:29 -0800 (PST)
In-Reply-To: <54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165194>

On Mon, Jan 17, 2011 at 7:23 PM, Aaron S. Meurer <asmeurer@gmail.com> w=
rote:
> On Jan 17, 2011, at 2:38 AM, Christian Couder <christian.couder@gmail=
=2Ecom>
> wrote:
>
>> Hi,
>>
>> On Sat, Jan 15, 2011 at 8:33 AM, Aaron S. Meurer <asmeurer@gmail.com=
>
>> wrote:
>>>
>>> First off, do you guys have an issue tracker?
>>
>> No, we don't. We use the mailing list.
>>
>
> Well that's amazing to me. How on Earth fo you manage stuff?

Well, bugs are usually fixed within days after they have been
reported. Otherwise they are usually documented in the code or in the
documentation or in the test suite (with test_expect_failure).

=46or the rest we rely on people remembering what happened and on
people's mailing list searching skills ;-)

>> If more people want it, yeah, we can create such a shortcut. But you
>> can also use a git alias for that.
>>
>
> Can you alias "git bisect stop", or would you have to alias "git
> bisect-stop"?

I think you have to alias "git bisect-stop".

I am not sure because when I use aliases I prefer to use shell aliases =
like:

alias gst=3D'git status'

>> Yeah, many people find it difficult to reverse the meaning of "bad"
>> and "good" when looking for a fix. There were some suggestions at so=
me
>> points to do something about it. Some of the suggestions were to use
>> some aliases for "good" and "bad", but there was no agreement. Other
>> suggestions had a patch attached but the patch was not good enough o=
r
>> something.
>>
>> Anyway, the restriction is that the "bad" commit cannot be an ancest=
or
>> of a "good" commit. But the "good" commits need not be all ancestors
>> of the "bad" commit. For example if you have a "master" branch and a
>> "dev" branch that was forked from the "master" branch at one point,
>> like that:
>>
>> A-B-C-D-E <-- master
>> =A0 =A0 \F-G <-- dev
>>
>
> I don't understand how this can only be one way? =A0Isn't this symmet=
ric? =A0In
> other words, how is it different from
>
> A-B-C-D-E <-- dev
> =A0 =A0\F-G <-- master
>
> as far as bisect is concerned? Or maybe I am not entirely clear on wh=
at you
> are saying.

Yes, it is symmetric, so we cannot just automatically reverse the
meanning because there is no "after" or "before" relationship between
"dev" and "master".

Best regards,
Christian.
