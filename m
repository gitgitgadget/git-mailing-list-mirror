Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15667C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18202078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLvZvDg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJLDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:03:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38053 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJLDG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:03:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5so2021721edq.5
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rEjbct6W5Hi76iuQVa8RojN+IkabX1bRJ3Dypb7Y61Y=;
        b=rLvZvDg+anfL6Y5KkzDUs/5asbClNa/mDuVUfU1F/HjItn50aoZMJFMbShvNXlUwB0
         +1Y33jl9JE4iA6Wtm6/vSl65gMIxGi0CLZ4kbJK9TI6lTeiPJJIBmBdcsH6l18uu1BsH
         WLL5d3+qFpouj5f1Hlh24wXL8jN5TsJDqDlcLNX1SrwT485/7EmNJ69Pn6t93ZYUE964
         7jbEDlzQwDC014V3xX8/fhbj+bArPPZDwaB76DQ+AkZbfY19EnOadmfHSNmW2OMUSkAA
         UhtBw13uqJapIxsI7r+QgaR1cVkgNBddUX6l+PaWvffbO+GwMKNc5rvBlsi9aLRyn8tH
         6J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rEjbct6W5Hi76iuQVa8RojN+IkabX1bRJ3Dypb7Y61Y=;
        b=C/OTGBceCvHYHetUnIV2DnL9VaMRxgexH8+jmjh/qA/ZueTokYH+TULyiPGJzgJ0GX
         5trd0RVIAXpwKHV1bhIBenxkRto3H4h8kVpPpCGGZeF3ENiOMQpwu38USb+33hwBhPuk
         +fUnsNA3qzFS8TLMcslzI+UvFxYf3TabEg0ymNJNvSe2p/1geIrCSGdW/o99L84nMyPH
         CY4N3uC4xqLWOPz0lHKyfmOYMaSba82qcpSjExOugchchv2nfoNsABnkreE/5jd3NjlM
         WnY0z4z29OXdk6crHj+pE0JW9S3zox8x2jeIUdcUAkD6rYkWJmdAKozojUene4CRfM/6
         67Bg==
X-Gm-Message-State: AGi0PubLDuemymouIB8kX4y2PkYIa2fRX6O7FRtCrGWXuWETKP9rtJET
        JbblLSlySFpqSwbigJgpXP4R0CMj
X-Google-Smtp-Source: APiQypKfyDY9L80U6ptKjRfEgWPtKKyu1CbrWRYcR1nyqmYiBjMjuT8XdNDaAkrIxn5ifdbbeK+asg==
X-Received: by 2002:a17:906:ce59:: with SMTP id se25mr3236076ejb.71.1586516584913;
        Fri, 10 Apr 2020 04:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id of22sm100607ejb.66.2020.04.10.04.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:03:04 -0700 (PDT)
Message-Id: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
References: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 11:03:00 +0000
Subject: [PATCH v2 0/3] Make the tests that test core.hideDotFiles more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have this feature on Windows where the files starting with a dot can be
marked hidden (whether a file is hidden by default or not is a matter of
naming convention on Unix, but it is an explicit flag on Windows). This
patch improves the regression tests of this feature, and it has been carried
in Git for Windows for over three years.

Junio, I'm sorry that I did not get to send v2 yesterday, and that you spent
time on the two add-on patches even after I finalized this second iteration
(but I was first waiting for the PR build to pass and while that happened, I
got stuck in meeting after meeting).

Changes since v1:

 * A preparatory patch now moves and renames is_hidden to 
   test-lib-functions.sh
 * A typo in the function's comment is fixed, while at it.

Johannes Schindelin (3):
  t: consolidate the `is_hidden` functions
  mingw: make test_path_is_hidden tests in t0001/t5611 more robust
  t: fix casing of the operating system `Windows`

 t/t0001-init.sh         |  9 +--------
 t/t5611-clone-config.sh | 13 +++----------
 t/test-lib-functions.sh | 10 ++++++++++
 3 files changed, 14 insertions(+), 18 deletions(-)


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-603%2Fdscho%2Frobustify-is-hidden-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-603/dscho/robustify-is-hidden-tests-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/603

Range-diff vs v1:

 -:  ----------- > 1:  dd81ea68d6b t: consolidate the `is_hidden` functions
 1:  889f7c21333 ! 2:  fc4202cb548 mingw: make is_hidden tests in t0001/t5611 more robust
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: make is_hidden tests in t0001/t5611 more robust
     +    mingw: make test_path_is_hidden tests in t0001/t5611 more robust
     +
     +    This function uses Windows' system tool `attrib` to determine the state
     +    of the hidden flag of a file or directory.
      
          We should not actually expect the first `attrib.exe` in the PATH to
          be the one we are looking for. Or that it is in the PATH, for that
          matter.
      
     +    Let's use the full path to the tool instead.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## t/t0001-init.sh ##
     -@@ t/t0001-init.sh: test_expect_success SYMLINKS 're-init to move gitdir symlink' '
     - # Tests for the hidden file attribute on windows
     - is_hidden () {
     - 	# Use the output of `attrib`, ignore the absolute path
     --	case "$(attrib "$1")" in *H*?:*) return 0;; esac
     -+	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
     - 	return 1
     - }
     + ## t/test-lib-functions.sh ##
     +@@ t/test-lib-functions.sh: test_path_is_hidden () {
     + 	BUG "test_path_is_hidden can only be used on Windows"
       
     -
     - ## t/t5611-clone-config.sh ##
     -@@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
     - # Tests for the hidden file attribute on windows
     - is_hidden () {
       	# Use the output of `attrib`, ignore the absolute path
      -	case "$(attrib "$1")" in *H*?:*) return 0;; esac
      +	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
       	return 1
       }
     - 
 -:  ----------- > 3:  d0c0767a2aa t: fix casing of the operating system `Windows`

-- 
gitgitgadget
