From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 09:49:57 +0100
Message-ID: <CAJ-05NNgVPukJchskVv9oL7-9p+txC0g_SXfHne-mwF327Q_3Q@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<20130531083252.GA1072@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 31 10:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiL2h-0004lo-Il
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab3EaIuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 04:50:08 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:39237 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab3EaIt7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 04:49:59 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so2480522obb.4
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=vVGVpX8BS4/BNH2Wu/V2vKzZmpk19AL3gAzgU/nnY6E=;
        b=Y6A3N/dcbRkJ9neatwawk8PzOqwOhAWnI3yuyamtLIs9/7qJ1ELdWAUHryP+qFuaZ/
         PeVYfGXO64m7Ph+BR9m/qkMlTnZ9hwEBflo+9ntdnAZK+UxJvSncs0t6HgoDSPC06Fwq
         ynmUsNQME+2Vd8S4qjjEFHzLbTI2sQwD0stbuI0qVDpcU9VNBlk/jSwnPSNlF0+chwY8
         u2JfqfLUNbtSLedg8BnfEIeLuig7ZT+ZglNAgC5OFk26unTTPL5tC1I2cgRhMyUtpjzt
         ygcU+jcPQbxZxEZ1buQY51063LqooPx4kjW5iIUDbVHx3jrocyJoA4DgpIwjHi/SnlqE
         2tGw==
X-Received: by 10.60.76.132 with SMTP id k4mr2134528oew.10.1369990197582; Fri,
 31 May 2013 01:49:57 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Fri, 31 May 2013 01:49:57 -0700 (PDT)
In-Reply-To: <20130531083252.GA1072@serenity.lan>
X-Google-Sender-Auth: 5r_V3f0t6yMK8oB9PCfU_hWnh0k
X-Gm-Message-State: ALoCoQmQomGPbxE1CwQcqn2dE8iyQligDn0rxEsWQztk/Yt8ay3Wj1ljLAZZ6KyRWto4Jm3touVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226084>

On 31 May 2013 09:32, John Keeping <john@keeping.me.uk> wrote:
> On Fri, May 31, 2013 at 09:14:49AM +0100, Alex Benn=C3=A9e wrote:
>> On 30 May 2013 20:30, John Keeping <john@keeping.me.uk> wrote:
>> > On Thu, May 30, 2013 at 06:21:55PM +0200, Thomas Rast wrote:
>> >> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>> >>
>> >> > On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
>> >> >> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>> > <snip>
>> >> > Will it be loading the blob for every commit it traverses or ju=
st ones that hit
>> >> > a tag? Why does it need to load the blob at all? Surely the com=
mit
>> >> > tree state doesn't
>> >> > need to be walked down?
>> >>
>> >> No, my theory is that you tagged *the blobs*.  Git supports this.
>>
>> Wait is this the difference between annotated and non-annotated tags=
?
>> I thought a non-annotated just acted like references to a particular
>> tree state?
>
> No, this is something slightly different.  In Git there are four type=
s
> of object: tag, commit, tree and blob.  When you have a heavyweight t=
ag,
> the tag reference points at a tag object (which in turn points at
> another object).  With a lightweight tag, the tag reference typically
> points at a commit object.

I think this is the case in my repo.

> However, there is no restriction that says that a tag object must poi=
nt
> to a commit or that a lightweight tag must point at a commit - it is
> equally possible to point directly at a tree or a blob (although a lo=
t
> less common).
>
> Thomas is suggesting that you might have a tag that does not point at=
 a
> commit but instead points to a blob object.

It's looking like I just have some very heavy commits. One data point
I probably should have mentioned at the beginning is this was a
converted CVS repo and I'm wondering if some of the artifacts that
introduced has contributed to this.

>> > You can see if that is the case by doing something like this:
>> >
>> >     eval $(git for-each-ref --shell --format '
>> >         test $(git cat-file -t %(objectname)^{}) =3D commit ||
>> >         echo %(refname);')
>> >
>> > That will print out the name of any ref that doesn't point at a
>> > commit.
>>
>> Hmm that didn't seem to work.
>
> You mean there was no output?  In that case it's likely that all your
> references do indeed point at commits.

Correct.

>
>>                               But looking at the output by hand I
>> certainly have a mix of tags that are commits vs tags:
>>
>>
>> 09:08 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags=
"
>> | grep "commit" | wc -l
>> 1345
>> 09:12 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags=
"
>> | grep -v "commit" | wc -l
>> 66
>
> This means that you have 1345 lightweight tags and 66 heavyweight tag=
s,
> assuming that all of the lines that don't say "commit" do say "tag".

Yep all commits and tags, nothing else

> By the way, I don't remember if you said which version of Git you're
> using.  If it's an older version then it's possible that something ha=
s
> changed.

I'm running the GIT stable PPA:

09:38 ajb@sloy/x86_64 [work.git] >git --version
git version 1.8.3

Although I have also tested with the latest git.git maint. I'm happy
to try master if it's likely to have changed.

--=20
Alex, homepage: http://www.bennee.com/~alex/
