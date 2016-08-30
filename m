Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936601F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 12:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758219AbcH3Mc1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 08:32:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32845 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758193AbcH3Mc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 08:32:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so2951678wme.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8hkg2rhTJ+RZNhSbHpOr0JsbamXBgq5umKFm5t8O5aU=;
        b=LgxIrIcgfSaeaixxSQ57lKXWI2alokaIaDPfINKd1ZZCPnVY2z7ArxbJjj4BtHT1t1
         niEYXKE4ymprqUrA2rrO2pNvZPjGn8WFfHvFGOSXcRjAfEvUQsS7kOo79C7g4ziWUIkR
         u5/ZrEngBE9RH6cuvGPebXXGQ6zN0XMVZE8Clu76tqBY2qzdXuWjrM8/39noL4E3+1HF
         l9Erv3eGZa4VKaXBJUE5BjF8f+iyLOX+aSS7s1FJqOKAnJ2JZ9riDtEQOPOaEi5X7LSO
         ypdlxDw49RMqHLmJovaLl/Os5jBLggXtG1q82OJr/YJSILjx1KCo7+is4wCzFFRSGLp+
         j4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8hkg2rhTJ+RZNhSbHpOr0JsbamXBgq5umKFm5t8O5aU=;
        b=crqMifsJM6FabKJaH7qcVdsLsH2ICQQ3CZPpEn9C8DG8BBL/YjjaEnRhaLTxPZFe/K
         WFkq2yNo3/dsqKGVkSI5NXZfWHPhXuKm+uHjyUTjg5PwNo0eGznWOn4zHNks8s3pHyTp
         FYcYa9SkvBoyRl9tZvQR8JDuehFq5B7+RNqBtoEqvGTrNjPqWwB3O9vBe6aFzO/Hjhrv
         bMU4aNIRp9SyepkWSI4mxJ1ZGE60EpDOeBwx4TRK9JuRbMpoZm3NGMEEJ67gsam71DvZ
         ULjSLAtxF1XALhPf4x4tVTXV8IAak/vHG/m+cMPelkF5NBapRGfUSUS3Y0ubEPtJ0uON
         jTCg==
X-Gm-Message-State: AE9vXwPpuxNWbL/TdV93ZrVm7QZ0+FZbFBnSTA3/lR9Pd8fOGdb1ik6vVGr1GDfuLHOfQQ==
X-Received: by 10.194.5.230 with SMTP id v6mr3582016wjv.92.1472560344605;
        Tue, 30 Aug 2016 05:32:24 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i3sm39334101wjd.31.2016.08.30.05.32.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 05:32:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 13/13] read-cache: make sure file handles are not inherited by child processes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq37lnbbpk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 30 Aug 2016 14:32:22 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A177D61-AA25-415A-808D-B6BDA3BB5C47@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-14-larsxschneider@gmail.com> <xmqqy43fbgcj.fsf@gitster.mtv.corp.google.com> <4D9E5AED-7003-4707-8791-1C25432DB558@gmail.com> <xmqq37lnbbpk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Aug 2016, at 21:45, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> I see. Thanks for the explanation.
>=20
> I expect the updated log message to explain the issue correctly
> then.

Sure!


>>> The parent is
>>> very likely to have pack windows open into .pack files and they need
>>> to be closed on the child side after fork(2) starts the child
>>> process but before execve(2) runs the helper, if we want to avoid
>>> file descriptor leaks.
>>=20
>> I think I understand what you are saying. However, during my tests
>> .pack file fd's were never a problem.
>=20
> I do not expect during the lifetime of your long-running helper
> anybody would try to unlink an existing packfile, so it is unlikely
> that "cannot unlink an open file on Windows" issue to come up.  And
> the cross-platform problem I pointed out is a fd leak; leaks would
> not show up until you run out of the resource, just like you
> wouldn't notice small memory leak here and there UNLESS you actively
> look for them.  I would be surprised if your "tests" found anything.
>=20
>> How would I find the open .pack file fd's?  Should I go through
>> /proc/PID/fd? Why is this no problem for other longer running
>> commands such as the git-credential-cache--daemon or git-daemon?
>=20
> Nobody said this is "no problem for others".  While discussing the
> patch that started this thread, we noticed that any open file
> descriptor the main process has when the long-running clean/smudge
> helper is spawned _is_ a problem.  Other helpers may share the same
> problem, and if they do, that is all the more reason that fixing the
> file descriptor leak is a good thing.
>=20
> The primary thing I was wondering was if we should open the window
> into packfiles with CLOEXEC, just like we recently started opening
> the tempfiles and lockfiles with the flag.  The reason why I asked
> if the site that spawns (i.e. run_command API) has an easy access to
> the list of file descriptors that we opened ONLY for ourselves is
> because that would make it possible to consider an alternative
> approach close them before execve(2) in run_commands API.  That
> would save us from having to sprinkle existing calls to open(2) with
> CLOEXEC.  But if that is not the case, opening them with CLOEXEC is
> a much better solution than going outside the program to "find" them
> in non-portable ways.

The pack files are opened before the filter process is forked. =
Therefore,
I think CLOEXEC makes sense for them. Should this change be part of this=20=

series? If yes, would it look like below? Should I adjust the function =
name?

Thanks,
Lars

diff --git a/sha1_file.c b/sha1_file.c
index d5e1121..759991e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1485,7 +1485,7 @@ int check_sha1_signature(const unsigned char =
*sha1, void *map,
=20
 int git_open_noatime(const char *name)
 {
-	static int sha1_file_open_flag =3D O_NOATIME;
+	static int sha1_file_open_flag =3D O_NOATIME | O_CLOEXEC;
=20
 	for (;;) {
 		int fd;



