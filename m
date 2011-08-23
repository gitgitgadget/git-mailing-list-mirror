From: Michael Witten <mfwitten@gmail.com>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 16:23:15 +0000
Message-ID: <CAMOZ1BuMfUT4D_UasLXsjDrXRKDw4EF_U-CV8tsS9W7AP+f8ow@mail.gmail.com>
References: <201108221525.32982.trast@student.ethz.ch> <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
 <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
 <20110823160525.GB3545@elie.gateway.2wire.net> <vpqliuk85ze.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, rdiezmail-temp2@yahoo.de,
	Thomas Rast <trast@student.ethz.ch>, in-git-vger@baka.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 23 18:23:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvtlX-0001oh-Lx
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 18:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab1HWQXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 12:23:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48325 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab1HWQXq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 12:23:46 -0400
Received: by gxk21 with SMTP id 21so214125gxk.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MGDhDzE9yLT/+YSGwEhMiXwAN0cH6u1g30nSns1AzGE=;
        b=wQ/qOg5ZqeWmowra16NzdsY12ivuH/vMofgGzddejRQl6nkc8DP8E2Q5PLqkqtw33y
         wcU0yGE/IgCZRgoHw12FFoyNDqGsEIaUYKMuRZzNvwYWAAiOBBmZ6RRmcGgi52ZpG/oW
         zLrpGPTp0k94xc/6JEdD8a8CztrdjcyOt/xnc=
Received: by 10.43.52.1 with SMTP id vk1mr3759875icb.129.1314116625133; Tue,
 23 Aug 2011 09:23:45 -0700 (PDT)
Received: by 10.42.138.66 with HTTP; Tue, 23 Aug 2011 09:23:15 -0700 (PDT)
In-Reply-To: <vpqliuk85ze.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179945>

On Tue, Aug 23, 2011 at 16:09, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Michael Witten wrote:
>>> On Mon, Aug 22, 2011 at 15:18, R. Diez <rdiezmail-temp2@yahoo.de> w=
rote:
>>
>>>> I still don't quite understand how git works, but let me
>>>> risk a naive statement here. If "a-b-c-M" were 'master',
>>>> and "d-e-f" were 'new-feature', then on April 1st the
>>>> current version on 'master' is 'b', because I merged the
>>>> 'new-feature' branch at a later point in time. Does that
>>>> make sense?
>>>
>>> O! for the love all that is Holy!
>>
>> Wait, what's wrong with what R. Diez said? =C2=A0It's exactly what
>> --first-parent gives you.
>
> Not really. Suppose, on April 1st, I have
>
> A--B--C <-master
> =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 D--E <-new-feature
>
> Then, I merge from upstream
>
> A--B-----C <-master
> =C2=A0 =C2=A0\ =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 D--E--F <-new-feature
>
> and then I push to master, or master fast-forward-pulls from me:
>
> A--B-----C
> =C2=A0 =C2=A0\ =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 D--E--F <-new-feature, master
>
> Then, what used to be in master on April 1st is C, but --first-parent
> will give you E instead.

Indeed. That example makes perfect sense when so-called `branches'
master and new-feature are rightfully thought of as the `pointers'
(or, `references') that they are.

Moreover, Jonathan, can't you see that your more knowledgeable mind
has automatically smoothed over the inaccuracies presented by R.
Diez's description? In particular, a `branch' has nothing to do with
walking a commit object's ancestry.
