From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 09:40:01 +0100
Message-ID: <CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 31 10:40:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKsr-0007do-RX
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891Ab3EaIkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 04:40:21 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:47727 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab3EaIkC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 04:40:02 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so2480011obb.28
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=dwWVGQxANuAVpJqP/7Kwa+zM/AQccwgpw9+HPhMQCjg=;
        b=c8gQRb2JwnkIBEnUI3063bZvNFW69bDH5Ik2gvqgjj7Z4FjQOSOo2A/b/pvaESU19U
         YxjBcmi7oNZEh/B2nSn2thVx05EuCvdwup5wLuygiRdIR3q1uGepbc0O+hkz0PvfZi3I
         cR1lTgJZuPxLQ/ncetf7PNshLwJldVkVWMGEyit4uUvr66W3y9h8heXRIfJh1JwgqF6F
         +1Rz9mVt7v6MCI2Q4nTVy1/U3YKWqXeJmHgDk9u2v8DcXycRQWdtR9EJezV2F+oW2qqZ
         a7BTTB3FetHZ9lGi5Z4eIVJRicvenkqgS7vS2Zl99Ece9Bx4QOJtUMtD8Q/RaLA9wQB/
         y7HQ==
X-Received: by 10.182.233.227 with SMTP id tz3mr5625226obc.23.1369989601743;
 Fri, 31 May 2013 01:40:01 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Fri, 31 May 2013 01:40:01 -0700 (PDT)
In-Reply-To: <87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
X-Google-Sender-Auth: whOxIaqAZJt_FWIH_3W0Kh7NQcc
X-Gm-Message-State: ALoCoQlMXqeayXt+UyF33RgXge9fbSz40UCIaOM/hVN2b/E22D8OTQaozg2XaBd8TCtC/zLpt3U+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226082>

On 31 May 2013 09:24, Thomas Rast <trast@inf.ethz.ch> wrote:
> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>> On 30 May 2013 20:30, John Keeping <john@keeping.me.uk> wrote:
>>> On Thu, May 30, 2013 at 06:21:55PM +0200, Thomas Rast wrote:
>>>> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>>>> > On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
> <snip>
>>>> No, my theory is that you tagged *the blobs*.  Git supports this.
>>
>> Wait is this the difference between annotated and non-annotated tags=
?
>> I thought a non-annotated just acted like references to a particular
>> tree state?
>
> A tag is just a ref.  It can point at anything, in particular also a
> blob (=3D some file *contents*).
>
> An annotated tag is just a tag pointing at a "tag object".  A tag obj=
ect
> contains tagger name/email/date, a reference to an object, and a tag
> message.
>
> The slowness I found relates to having tags that point at blobs direc=
tly
> (unannotated).

I think you are right. I was brave (well I assumed the tags would come
back from the upstream repo) and ran:

git for-each-ref | grep "refs/tags" | grep "commit" | cut -d '/' -f 3
| xargs git tag -d

And boom:

09:19 ajb@sloy/x86_64 [work.git] >time /usr/bin/git --no-pager
describe --long --tags
ajb-build-test-5225-2-gdc0b771

real    0m0.009s
user    0m0.008s
sys     0m0.000s

Which is much better performance. So it does look like unannotated
tags pointing at binary blobs is the failure case.

<snip>
>
> I would be more interested in this:
>
>   git for-each-ref | grep ' blob'

Hmmm that gives nothing. All the refs are either tag or commit

> and
>
>   (git for-each-ref | grep ' blob' | cut -d\  -f1 | xargs -n1 git
>cat-file blob) | wc -c

However I have some big commits it seems:

09:37 ajb@sloy/x86_64 [work.git] >(git for-each-ref | grep ' commit' |
cut -d\  -f1 | xargs -n1 git cat-file commit) | wc -c
1147231984

>
> The first tells you if you have any refs pointing at blobs.  The seco=
nd
> computes their total unpacked size.  My theory is that the second yie=
lds
> some large number (hundreds of megabytes at least).
>
> It would be nice if you checked, because if there turn out to be big
> blobs, we have all the pieces and just need to assemble the best
> solution.  Otherwise, there's something else going on and the problem
> remains open.

If you want any other numbers I'm only too happy to help. Sorry I
can't share the repo though...

--=20
Alex, homepage: http://www.bennee.com/~alex/
