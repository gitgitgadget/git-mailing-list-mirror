From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Mon, 2 Mar 2015 20:42:30 +0100
Message-ID: <CACBZZX4rjYoQZRkzrfBYp8jOFwGm64Eh2-6JpJJ=KMFNxCOkbg@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
 <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com>
 <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
 <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com> <54EC7241.7000500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 02 20:43:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWFD-00029O-PH
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 20:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbbCBTmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2015 14:42:52 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54657 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbbCBTmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 14:42:51 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so33610477obc.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8qwH06KonT7IrmEJ6ASFdQ6ccxeHnrRKysw2bEbmnYY=;
        b=tY1rwgX1O5QzWf/9KanMyo3HNeZv7Go8mw0KGxUIzNVjws6B8jUEY+eg6YNIEoKwm7
         7o5o3Cvz8s9lhIsGzpDdDiDS142+enmtFT/N1a8k4e0G4zKeq5J+pBrgESnUpkG/DRVs
         JaXN8AgtJQFLCooP+0uIzqX4NuDt6sdnDKT12C4allxB5PWZgTf17SdAFeq1E9+mv7Hk
         anMKLXhiY8yWdf67WOajRB2emWP8wYN9E1cvFfdpv2jdO+HemjLFSobEvl8EY9jK2WlC
         IJP/bW3su27Lv/wYZiez9eP/xk9S3mwSkwaRicukOu5gKioRDgK23W2VHu/JTFrQwuob
         d4bg==
X-Received: by 10.202.58.8 with SMTP id h8mr19541402oia.93.1425325370782; Mon,
 02 Mar 2015 11:42:50 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Mon, 2 Mar 2015 11:42:30 -0800 (PST)
In-Reply-To: <54EC7241.7000500@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264612>

On Tue, Feb 24, 2015 at 1:44 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 02/20/2015 03:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Feb 20, 2015 at 1:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
>> <avarab@gmail.com> wrote:
>>> On Fri, Feb 20, 2015 at 1:04 AM, Duy Nguyen <pclouds@gmail.com> wro=
te:
>>>> On Fri, Feb 20, 2015 at 6:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason
>>>> <avarab@gmail.com> wrote:
>>>>> Anecdotally I work on a repo at work (where I'm mostly "the Git g=
uy") that's:
>>>>>
>>>>>  * Around 500k commits
>>>>>  * Around 100k tags
>>>>>  * Around 5k branches
>>>>>  * Around 500 commits/day, almost entirely to the same branch
>>>>>  * 1.5 GB .git checkout.
>>>>>  * Mostly text source, but some binaries (we're trying to cut dow=
n[1] on those)
>>>>
>>>> Would be nice if you could make an anonymized version of this repo
>>>> public. Working on a "real" large repo is better than an artificia=
l
>>>> one.
>>>
>>> Yeah, I'll try to do that.
>>
>> tl;dr: After some more testing it turns out the performance issues w=
e
>> have are almost entirely due to the number of refs. Some of these I
>> knew about and were obvious (e..g. git pull), but some aren't so
>> obvious (why does "git log" without "--all" slow down as a function =
of
>> the overall number of refs?).
>
> I'm assuming that you pack your references periodically. (If not, you
> should, because reading lots of loose references is very expensive fo=
r
> the commands that need to iterate over all references!)

Yes, as mentioned in another reply of mine, like this:

    git --git-dir=3D{} gc &&
    git --git-dir=3D{} pack-refs --all --prune &&
    git --git-dir=3D{} repack -Ad --window=3D250 --depth=3D100
--write-bitmap-index --pack-kept-objects &&

> On the other hand, packed refs also have a downside, namely that
> whenever even a single packed reference has to be read, the whole
> packed-refs file has to be read and parsed. One way that this can bit=
e
> you, even with innocuous-seeming commands, is if you haven't disabled
> the use of replace references (i.e., using "git --no-replace-objects
> <CMD>" or GIT_NO_REPLACE_OBJECTS). In that case, almost any Git comma=
nd
> has to read the "refs/replace/*" namespace, which, in turn, forces th=
e
> whole packed-refs file to be read and parsed. This can take a
> significant amount of time if you have a very large number of referen=
ces.

Interesting. I tried the rough benchmarks I posted above with
GIT_NO_REPLACE_OBJECTS=3D1 and couldn't see any differences, although a=
s
mentioned in another reply --no-decorate had a big effect on git-log.

> So try your experiments with replace references disabled. If that hel=
ps,
> consider disabling them on your server if you don't need them.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
