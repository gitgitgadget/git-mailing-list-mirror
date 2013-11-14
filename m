From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 19:17:07 +0530
Message-ID: <5284D45B.2040904@gmail.com>
References: <20130601050355.GA23408@sigill.intra.peff.net> <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com> <20130601090934.GA13904@sigill.intra.peff.net> <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com> <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com> <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com> <528416EA.1070307@gmail.com> <87bo1nmn6w.fsf@linux-k42r.v.cablecom.net> <20131114080735.GB16327@sigill.intra.peff.net> <5284AC6E.4030208@gmail.com> <20131114110937.GA11597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 14 14:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgxGO-0002jE-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 14:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab3KNNrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 08:47:13 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:42790 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab3KNNrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 08:47:12 -0500
Received: by mail-pb0-f51.google.com with SMTP id xa7so2061030pbc.10
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 05:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PBuU0WDfGolDGTaLhmDGyWL2TMUO26+NCiz2afzL8G0=;
        b=vC/dUF0822X8c6qBtPVublEos71hSZ8B+UA3l3O9FSIYM0QweFLoLh03f+wuWFyCa9
         Svup/ieBhtd1PUlJb4o3NEkpWaP8f8F1vctFYDzq92UBMqMj9duQZccQ81N2B6pzbDk0
         Xet7zzrVn4cwFqsKgkXpQ6C76bTP1pCkoQEREO4IrqT1U4P6QFPpjrM+SZvqTR9yhk8+
         LCEf/7yb+LHmLutywAfPTFT1qjznXCO55ADcNYK7w68bEowwoFH8PRrNq2sTg8fzMakF
         aT8VtqHqevIUPy/5f1gwWOHAZVMrRU/CykmUyOfTmMUoUWqhsYcfpcE4kWfMa4d2nPmx
         Gj5g==
X-Received: by 10.68.163.33 with SMTP id yf1mr1389942pbb.143.1384436831747;
        Thu, 14 Nov 2013 05:47:11 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.164.152])
        by mx.google.com with ESMTPSA id qf7sm59295555pac.14.2013.11.14.05.47.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 05:47:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131114110937.GA11597@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237848>

On 11/14/2013 04:39 PM, Jeff King wrote:
> On Thu, Nov 14, 2013 at 04:26:46PM +0530, Sitaram Chamarty wrote:
> 
>>> I do not know about any particular debate in git circles, but I assume
>>> Sitaram is referring to this incident:
>>>
>>>   https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/t4nkXONp8qgJ
>>>
>>> in which a Jenkins dev force-pushed and rewound history on 150 different
>>> repos. In this case the reflog made rollback easy, but if he had pushed
>>> a deletion, it would be harder.
>>
>> I don't know if they had a reflog on the server side; they used
>> client-side reflogs if I understood correctly.
>>
>> I'm talking about server side (bare repo), assuming the site has
>> core.logAllRefUpdates set.
> 
> Yes, they did have server-side reflogs (the pushes were to GitHub, and
> we reflog everything). Client-side reflogs would not be sufficient, as
> the client who pushed does not record the history he just rewound (he
> _might_ have it at refs/remotes/origin/master@{1}, but if somebody
> pushed since his last fetch, then he doesn't).
> 
> The "simplest" way to recover is to just have everyone push again
> (without --force). The history will just silently fast-forward to
> whoever has the most recent tip. The downside is that you have to wait
> for that person to actually push. :)
> 
> I think they started with that, and then eventually GitHub support got
> wind of it and pulled the last value for each repo out of the
> server-side reflog for them.

Great.  But what does github do if the branches were *deleted* by
mistake (say someone does a "git push --mirror"; most likely in a
script, for added fun and laughs!)

Github may be able to help people recover from that also, but plain Git
won't.

And that's what I would like to see a change in.

> 
> -Peff
> 
