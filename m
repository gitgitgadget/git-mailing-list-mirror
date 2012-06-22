From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 13:14:03 -0700
Message-ID: <CAE1pOi3pe4KKeJ4B74T8besvbiJh-dJz5efB-qJLsbmK+f_YLQ@mail.gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <CABURp0oCrmJzfFtX9UujMfoTPeCBPeuri6pb4nTq57XvuO98aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 22:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiAFV-0001U9-O3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 22:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017Ab2FVUO3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 16:14:29 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53308 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456Ab2FVUO2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 16:14:28 -0400
Received: by gglu4 with SMTP id u4so1879482ggl.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xqcdL0Pno84srpUDnZlqAAtu5hv+kGHLPuifENpwiLM=;
        b=t8N5T2xkFv/OJStjYfMGLDuIJoo4OGh7liFY9hU4GSSa3DGdeLdR0rHCHWwS+tJhy4
         EFx79gT44cGMOJbEnzQh+c++Ww25waWHTpqT/kD8eF6ymFWGyGl7eL5JIs0hpTljqNsn
         jineZ1oxoueqbSFRqs34jET+w1SzBV3xd5l2V2m3zCOLPCYACuOtubyTCRB+7ZSJXYtn
         DbCAOwu1AbXtxO45SGjGBRVe95462NS8qjs7rg4z1KqTBAEoszZSbywSPHi3jSUnBpCw
         oyMoGbH8P0bJwtPVuDNSChfin557XMAqe/+X9x+u5bgokD16KhEyX63fkrgj8h4EYDmG
         NTWg==
Received: by 10.236.185.105 with SMTP id t69mr3709061yhm.106.1340396067899;
 Fri, 22 Jun 2012 13:14:27 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Fri, 22 Jun 2012 13:14:03 -0700 (PDT)
In-Reply-To: <CABURp0oCrmJzfFtX9UujMfoTPeCBPeuri6pb4nTq57XvuO98aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200465>

Hi Phil,

On 22 June 2012 11:34, Phil Hord <phil.hord@gmail.com> wrote:
> On Fri, Jun 22, 2012 at 1:53 PM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> One of my developers managed to push something that somehow "diverge=
d"
>> origin/master from everyone else's local master.
>>
>> A --> B --> C --> D (everybody's local master)
>> |
>> \--> B' --> C' --> D' --> E (origin/master)
>>
>> (i.e., A is the commit where things diverged; everyone's local maste=
r
>> points to D but the new commit (E) that was pushed to origin/master
>> uses different SHA1s for B, C, and D). I hope I explained it clearly
>> enough.
>>
>> Now running git pull creates a merge commit joining D and E.
>>
>> When I asked the developer what he had done he told me everything ha=
d
>> looked normal. No Git warnings, nothing strange in gitk (i.e. normal
>> linear history). So I do not understand what went wrong.
>>
>> Does anyone have any idea as to what might have happened? Perhaps if=
 I
>> understand how this happened I might be able to prevent it from
>> happening again.
>
> There are a number of ways this can happen, but they all involve
> rewriting history. =C2=A0Usually that is something your developer wou=
ld be
> aware of doing. =C2=A0It does not usually happen by mistake.

My thoughts exactly.

> Also, in order to push the new E commit, the developer would have to
> "force" the push by placing a "+" in front of the references, like
> this:
>
> =C2=A0git push origin +master:master

Is that the same as

git push --force origin master

?

> If he used a gui, then I do not know how this option would be spelled=
,
> but it may be called "force" or something else.

AFAIK, he uses the CL for this. No GUI.

> You can look at the reflog on the developer's machine to determine
> where the new commits came from. =C2=A0For example, here are some com=
mits I
> rebased a few weeks ago in a repository on my machine:
>
> $ git reflog --relative-date
> c93b31b HEAD@{6 weeks ago}: checkout: moving from mine to c93b31b
> 93a357f HEAD@{6 weeks ago}: rebase finished: returning to refs/heads/=
mine
> 93a357f HEAD@{6 weeks ago}: rebase: Add a makefile to help me remembe=
r
> how to make
> f804993 HEAD@{6 weeks ago}: rebase: Allow working in multiple branche=
s
> c93b31b HEAD@{6 weeks ago}: rebase: Update Gerrit 2.4 ReleaseNotes
> 5cac09e HEAD@{6 weeks ago}: rebase: Gerrit 2.4 ReleaseNotes
> f41a9b4 HEAD@{6 weeks ago}: checkout: moving from mine to
> f41a9b447304733a1784ece373723f8622c8dbad^0
> 879e5d9 HEAD@{6 weeks ago}: rebase finished: returning to refs/heads/=
mine
> 879e5d9 HEAD@{6 weeks ago}: rebase: Add a makefile to help me remembe=
r
> how to make
> 35d7a48 HEAD@{6 weeks ago}: rebase: Allow working in multiple branche=
s
> c7a845a HEAD@{6 weeks ago}: rebase: Update Gerrit 2.4 ReleaseNotes
> 7b51315 HEAD@{6 weeks ago}: rebase: Gerrit 2.4 ReleaseNotes
> d6799b1 HEAD@{6 weeks ago}: checkout: moving from mine to
> d6799b1d40ffc5412e4174fd95bd5fb412781537^0
> d9bb39b HEAD@{6 weeks ago}: checkout: moving from
> d6799b1d40ffc5412e4174fd95bd5fb412781537 to mine
> d6799b1 HEAD@{6 weeks ago}: checkout: moving from mine to origin/mast=
er
> d9bb39b HEAD@{6 weeks ago}: commit (amend): Add a makefile to help me
> remember how to make
> 62097f8 HEAD@{6 weeks ago}: commit: Add a makefile to help me remembe=
r
> how to make
> dfa61e4 HEAD@{6 weeks ago}: checkout: moving from
> dfa61e465bcb27f5698c48d1ec9d32e8fd62c604 to mine

bb91ffa HEAD@{87 minutes ago}: checkout: moving from master to viz
bb91ffa HEAD@{88 minutes ago}: checkout: moving from viz to master
bb91ffa HEAD@{2 hours ago}: rebase finished: returning to refs/heads/vi=
z
bb91ffa HEAD@{2 hours ago}: checkout: moving from viz to
bb91ffa3db35852bf6e9b15855421a1c5117b2f2^0
df9529a HEAD@{2 hours ago}: checkout: moving from master to viz
bb91ffa HEAD@{2 hours ago}: pull origin master: Fast-forward
cceee83 HEAD@{2 hours ago}: reset: moving to HEAD~23
df9529a HEAD@{2 hours ago}: checkout: moving from viz to master
df9529a HEAD@{2 hours ago}: checkout: moving from master to viz
df9529a HEAD@{6 hours ago}: checkout: moving from master to master
df9529a HEAD@{18 hours ago}: checkout: moving from master to master
df9529a HEAD@{18 hours ago}: checkout: moving from master to master
df9529a HEAD@{18 hours ago}: reset: moving to
df9529a4249b9de9cc1956283e5210b68acfe507
6633b41 HEAD@{18 hours ago}: pull origin master: Fast-forward
df9529a HEAD@{18 hours ago}: reset: moving to
df9529a4249b9de9cc1956283e5210b68acfe507
6633b41 HEAD@{18 hours ago}: checkout: moving from master to master
6633b41 HEAD@{18 hours ago}: pull origin master: Merge made by the
'recursive' strategy.
df9529a HEAD@{18 hours ago}: checkout: moving from master to master
df9529a HEAD@{18 hours ago}: rebase finished: returning to refs/heads/m=
aster
df9529a HEAD@{18 hours ago}: rebase: Fixed some visualization bug,
added resources for new spark visualization, deleted obsolete
resources
8944283 HEAD@{18 hours ago}: rebase: Clean up social-sticky-widget.
f9bc439 HEAD@{18 hours ago}: rebase: Resolve build error
14373e3 HEAD@{18 hours ago}: rebase: Changed social-widget
add-friend-button binding names.
abf30b9 HEAD@{18 hours ago}: rebase: Added social-sticky-widget to the
community lounge.
d01d4da HEAD@{18 hours ago}: rebase: Extend email support.
0a60fe0 HEAD@{18 hours ago}: rebase: Fixed asyncronous text and slowed
plane by 50%. (37.5% slower in total than original speed)
4777fdd HEAD@{18 hours ago}: rebase: Added social-sticky-widget.
e744734 HEAD@{18 hours ago}: rebase: Slowed plane speed down by 25%
and increased the font size.
52137b7 HEAD@{18 hours ago}: rebase: Fixed some graphical glitches
with the plane.
6e60b86 HEAD@{18 hours ago}: rebase: Updated the header and island to
only show nature path in demo.
23c8ccb HEAD@{18 hours ago}: rebase: Added plane to the header and
remove dock from production.
1107a7e HEAD@{18 hours ago}: rebase: Show completed Quests in Activity =
Summary.
260f8c5 HEAD@{18 hours ago}: rebase: Added dock to header and island sw=
f.
0819d2c HEAD@{18 hours ago}: rebase: [DE575] Change friend bonus percen=
tage.
17685ba HEAD@{18 hours ago}: rebase: Improve level queries.
35d69b4 HEAD@{18 hours ago}: rebase: Refactor Period.
9749d52 HEAD@{18 hours ago}: rebase: Make sure to use correct date rang=
e.
180b648 HEAD@{18 hours ago}: rebase: Added fix for images that were
not working in IE8 and cleaned up some commented code.
f94e317 HEAD@{18 hours ago}: checkout: moving from master to
f94e317e82ea939a931cdc691e267e7c64f4dc00^0
38f2bb6 HEAD@{19 hours ago}: commit: Fixed some visualization bug,
added resources for new spark visualization, deleted obsolete
resources
98f2a97 HEAD@{19 hours ago}: pull origin master: Fast-forward
b325a96 HEAD@{32 hours ago}: pull origin master: Fast-forward
f94e317 HEAD@{8 days ago}: checkout: moving from
f884b312dcdb247ddf7eaf7c11eb9ffaab034b40 to master
f884b31 HEAD@{8 days ago}: checkout: moving from master to
f884b312dcdb247ddf7eaf7c11eb9ffaab034b40^0
f94e317 HEAD@{8 days ago}: commit: Fixed visualizations scaling and
integration of nature visualization
5ab4887 HEAD@{8 days ago}: pull origin master: Fast-forward
564abdd HEAD@{9 days ago}: pull origin master: Fast-forward
283c602 HEAD@{11 days ago}: pull origin master: Fast-forward

I have left it in just to be complete but you should ignore everything
"2 hours ago" and more recent. (I fixed the problem and told him to
pull again; the advantage of a small team.)

This leads to 2 new questions.

1) What does "checkout: moving from master to master" mean?
2) I'm guessing the root of the problem is "pull origin master: Merge
made by the 'recursive' strategy."? I do not see a push anywhere,
though.

> You can see the new commit SHA-1's on the lines that say "rebase:
> <original commit message>"
>
> But there are other ways to rewrite history, such as filter-branch.

Given that *I* do not even really know about that, I doubt he would. :-=
)

> You can also compare the commits to see what the differences are.
> This may trigger =C2=A0the developer's memory about how it might have
> happened.

The only differences seem to be the SHA-1s.

Cheers,
Hilco
