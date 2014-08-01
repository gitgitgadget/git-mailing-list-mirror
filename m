From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: cherry picking and merge
Date: Fri, 01 Aug 2014 18:27:20 +0200
Message-ID: <53DBBFE8.8060607@gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Stump <mikestump@comcast.net>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 18:27:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDFg8-0006Aj-Qt
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 18:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbaHAQ1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 12:27:33 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:45400 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaHAQ1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 12:27:32 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so4448833wgg.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OKu5tb4q18yi4gPwjqadqzR+T2YyIDplrPiyGvJJ+Fw=;
        b=PKnb49WcSNYGaQr9ylPEC97jia4uNjd93R6iFCpTvB1OrzwViPFrQOevLbpdMdAhGi
         z7VWukb9wF3jCw/+lc8o+W0DWmEINhZRZjQEon2pshrzIvS3U8bYJddEppSMKARifaZT
         OtqNddXEI0DRdeV6g88C9GjGf+Yv/MDfv9ThONnClcfDE+1FT+DG4/8BZLM2yQOXHv3b
         jyZ5upEqA+AJik6nwnc8VNwC1P5Jf9zeZBf++ver7Bp0HhNpYNLlhFxpOFhLEsYGzdnd
         dOjTc7H/MhNEGsF4HjeaMyTy8EMXNX3ogpX+T9bYi0IeLflwDqK41Z94aFoJyEE7v8ZM
         +cqg==
X-Received: by 10.194.24.2 with SMTP id q2mr9326386wjf.91.1406910449440;
        Fri, 01 Aug 2014 09:27:29 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id gc1sm10108360wib.22.2014.08.01.09.27.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 09:27:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254629>

W dniu 2014-08-01 04:43, brian m. carlson pisze:
> On Thu, Jul 31, 2014 at 05:58:17PM -0700, Mike Stump wrote:

>> Cherry picking doesn=E2=80=99t work as well as it should.  I was tes=
ting on
>> git version 1.7.9.5.
>>
>> Put in a line in a file, call it:
>>
>> first version
>>
>> then cherry pick this into your branch. Then update on master and tr=
ansform that into:
>>
>> second version
>>
>> then, merge that branch back to master.  Death in the form of confli=
cts.
>>
>> In gcc land, I do this sort of thing all the time, and I need a
>> merging subsystem to actually keep track of things.  I can manage th=
is
>> will diff and patch and it works flawlessly.  The point of using
>> something better than diff and patch is for it to be better than dif=
f
>> and patch.
>>
>> I=E2=80=99d like for merge to merge in the work that has yet to be m=
erged.
>> Not that, plus blindly try and apply or reapply cherry picked items.

Note that you should try to avoid cherry-picking, as they do not
leave trace in the graph of revisions.

=46or example if you are creating a bugfix, instead of putting it
directly on maint, and then cherry-picking to master, it is better
to create a separate feature branch for this fix (based at an early
version), and then merge said branch into maint, then into master.
It is described in blog post by Junio Hamano (which I cannot find now).

> You're not the first person to be surprised by the way merge works.
>  From the git-merge manpage:
>
>    [This behavior] occurs because only the heads and the merge base a=
re
>    considered when performing a merge, not the individual commits.
>
> (That was added after 1.7.9.5.)
>
> If you want the behavior of applying multiple patches in a row, you w=
ant
> to use git rebase, not git merge.  Since rebase re-applies the patche=
s
> of each of your commits on top of another branch, the identical chang=
e
> won't cause conflicts.

There is also git-imerge, third party tool that is intended to help
merging changes (and make it possible to do it in incremental way).

HTH
--=20
Jakub Nar=C4=99bski
