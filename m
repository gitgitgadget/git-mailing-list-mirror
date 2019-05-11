Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A321F461
	for <e@80x24.org>; Sat, 11 May 2019 21:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEKVm3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 17:42:29 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35440 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKVm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 17:42:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id q13so893695vso.2
        for <git@vger.kernel.org>; Sat, 11 May 2019 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z7yUgykZa14+jt6IpzSeiX0ZIkFZ8TCzVcAFuZ9Vrcs=;
        b=PDrzhn22JQGUHFvvNH9+0syhBp7MgnOYKr+A2Se0L1TsoBK0DK1nmS3gZBsxvd94GS
         oZqG2aMfxdVwhXKqjRA2N4SpDat4sO36fmgcNodAc4tXuunIYe3VV3a6OHQO+wfohWoj
         1z0EIZ9cY4QqpQ5uEDyyRHoni9lVBzdu4d/6+SidOOzkhNejLZxoVS+kg9NnIb9KbarI
         m/JscTvgqJAXmOTLMdIUEc4nFT5JX8Au++RdOX+w9CIu/ATerD36Y4hjGm+U2ujgNkF3
         tYL2ttchsinKYsOMn6xwMJGEWKGlEWxmn7/YkjWKafWvZM0jTnY1nbn9/+G1VqGqd5Aj
         4Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z7yUgykZa14+jt6IpzSeiX0ZIkFZ8TCzVcAFuZ9Vrcs=;
        b=kbvPZj/UJbjqHOMRayPaYAMW6N2VoM+gnzekFTCj1/jzAh7jNFyZKOnMdVZfTzvLWI
         StUzZUxu1Si/sNnBLQwXnu7NfuZN9eUOww6PcTEFY+WO5SMAYlFd2sNyedon6knx68vx
         vz6x75Qxto4R/ZDFTtbNhUmFMpMdu4/mVS5HsCjQYnIcdIuu1BDdH5ADEFgD7FGYFqiq
         TyFS6oUj/aw0pB3zqJVa6HrV+zd/IyTOnefB1urdzbEMZMkPtbAxPRQEayRq92XbspI8
         NbhqS4ab3/Q9gFVaCDkwGbFyqyYP8ayitnrVTpwl5EmAzZ15J2fIvWfyR70QzbR77sK3
         g6ag==
X-Gm-Message-State: APjAAAUdvLdh4PBamPtOUXIdCRV4asDajonH71CcllSgXa80sX2fMcQK
        7/NTqI6ez6dg8bzqIGriLGkULJ8I4ogVmuYHeh4=
X-Google-Smtp-Source: APXvYqw+307iddUMBonxQTvZk8pE82Xyz81owQtpy6RBNrNAJblwUuYcffEDRG3rgkPUOIX31Rw+/9f8Ems7cMLKR1A=
X-Received: by 2002:a67:6f07:: with SMTP id k7mr9293168vsc.117.1557610948327;
 Sat, 11 May 2019 14:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190430182523.3339-1-newren@gmail.com> <20190510205335.19968-1-newren@gmail.com>
 <20190510205335.19968-6-newren@gmail.com> <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
In-Reply-To: <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 May 2019 14:42:17 -0700
Message-ID: <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 11, 2019 at 2:07 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> On Fri, May 10, 2019 at 01:53:35PM -0700, Elijah Newren wrote:

> This one is good:
> > +     if (unset || !strcmp(arg, "abort"))
> > +             reencode_mode =3D REENCODE_ABORT;
>
> But here: does it make sense to use REENCODE_YES/NO to be more consistant=
 ?
> > +     else if (!strcmp(arg, "yes"))
> > +             reencode_mode =3D REENCODE_PLEASE;
> > +     else if (!strcmp(arg, "no"))
> > +             reencode_mode =3D REENCODE_NEVER;

Didn't realize there was any such convention, and even have difficulty
finding it with grep (CONTAINS_{YES,NO} appears to be the only example
I can find), but the alternate wording seems fine; I'm happy to adopt
it.

> > +             case REENCODE_ABORT:
> > +                     die("Encountered commit-specific encoding %s in c=
ommit "
> > +                         "%s; use --reencode=3D<mode> to handle it",
> Should we be more helpfull and say !use --reencode=3D[yes|no] to handle i=
t ?

Sounds like a good idea; I'll adjust it.


> > +     sed "s/wer/i18n-no-recoding/" iso-8859-7.fi |
> > +             (cd new &&
> > +              git fast-import &&
> > +              # The commit object, if not re-encoded, is 240 bytes.
> > +              # Removing the "encoding iso-8859-7\n" header would drop=
s 20
> > +              # bytes.  Re-encoding the Pi character from \xF0 in
> > +              # iso-8859-7 to \xCF\x80 in utf-8 would add a byte.  I w=
ould
> > +              # grep for the specific bytes, but Windows lamely does n=
ot
> This is somewhat unclear to me. What does Windows not allow ?
> > +              # allow that, so just search for the expected size.
> > +              test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
> > +              # Also make sure the commit has the "encoding" header
> > +              git cat-file commit i18n-no-recoding >actual &&
> > +              grep ^encoding actual)
> > +'

Windows does not allow specifying the bytes I want to grep for on the
command line; it'll munge the command line, resulting in it searching
for something other than what I wanted to be searched for, and return
the wrong answer based on searching for the wrong thing.  See
https://public-inbox.org/git/f8eb246f-a936-e9df-4bb4-068b86a62baf@kdbg.org/
and https://public-inbox.org/git/nycvar.QRO.7.76.6.1905101551110.44@tvgsbej=
vaqbjf.bet/.

My comment was already pretty long because it looks like a crazy way
to run the test and thus it feels like I need to explain it.  And the
craziness is based on how Windows behaves; it seems insane to me that
Windows decides to munge user data (in the form of the command line
provided), so much so that it makes me wonder if I really understood
Hannes' and Dscho's explanations of what it is doing.  (How could
anyone have thought munging user data was a good idea?)  Anyway, long
story short, I'm not sure how to explain it correctly and succinctly.
Any suggestions?


Elijah
