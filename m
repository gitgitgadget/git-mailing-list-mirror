Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA3C4743E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B3661364
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFGA4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 20:56:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62332 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFGA4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 20:56:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41D7613C81D;
        Sun,  6 Jun 2021 20:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0aji1ZNNcWs4zJfsEzp8+U9u/95APQa2vr2j3X
        VkWCI=; b=xIk9Jr09lN/cQR5vY/jLox871vp1ow1VmhOCbzxf+Puudomz8nRc2c
        +40SqSo4hjYv2atXkGSoHoD98yekr899yDSSI1Sa6jlkdhMKaYqfsMLvNtJ0l23n
        yWvjHjkIG2HF0v6MF5iz15DI4bgA8SD6/5vmkKTmcYnYGqGV55deM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A6FE13C81C;
        Sun,  6 Jun 2021 20:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82E5413C818;
        Sun,  6 Jun 2021 20:54:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2 0/3] Make CMake work out of the box
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
        <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 09:54:28 +0900
In-Reply-To: <pull.970.v2.git.1622980974.gitgitgadget@gmail.com> (Matthew
        Rogers via GitGitGadget's message of "Sun, 06 Jun 2021 12:02:51
        +0000")
Message-ID: <xmqqpmwywl2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAB99BAE-C72A-11EB-8056-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This pull request comes from our discussion here[1], and I think these
> patches provide a good compromise around the concerns discussed there
>
> 1:
> https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/
>
> CCing the people involved in the original discussion. cc: Philip Oakley
> philipoakley@iee.email cc: Sibi Siddharthan
> sibisiddharthan.github@gmail.com, cc: Johannes Schindelin
> johannes.schindelin@gmx.de, cc: Danh Doan congdanhqx@gmail.com
>
> Matthew Rogers (3):
>   cmake: add knob to disable vcpkg
>   cmake: create compile_commands.json by default
>   cmake: add warning for ignored MSGFMT_EXE

I am neither cmake nor windows person, so I'll queue this as-is and
wait for the stakeholders to chime in.

I did wonder if we want this to be applicable to the maintenance
track for 2.31, though.  There is a textual conflict with the
addition of SIMPLE_IPC that happened during 2.32 cycle, which is
easily resolvable.

I am tempted to queue a version of these three patches rebased on to
'maint' after making sure that the result of merging that into
'master' is byte-for-byte identical to applying these three patches
directly on to 'master'.

The range-diff looks like the attached.  Thanks.

1:  546c49cc88 ! 1:  585b7ca371 cmake: add knob to disable vcpkg
    @@ contrib/buildsystems/CMakeLists.txt: endif()
      	if(NOT EXISTS ${MSGFMT_EXE})
      		message(WARNING "Text Translations won't be built")
      		unset(MSGFMT_EXE)
    -@@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
    - file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
    +@@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
      file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
      file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
    + file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
     -if(WIN32)
     +if(USE_VCPKG)
      	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
2:  efa8681a22 = 2:  1cba2f9bd1 cmake: create compile_commands.json by default
3:  ceeca2bc0d = 3:  7824e74976 cmake: add warning for ignored MSGFMT_EXE
