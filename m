Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEF1F428F
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107482; cv=none; b=KI+ME/EGCU/x2fTjssbmzSSVHeFFW8ZY06mfGA5uiPsXhs0fnH3nLezXQyEbUWQqVssPgxro9aCQrdw531TA+y3fNdf7dl1XkY49XKkHrHB+v1aZwYpBOz0xtRrsp63TYLiPZSBjkwcbUwGbyZulXAHkyr6U9DsldXADqhvndwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107482; c=relaxed/simple;
	bh=YOMcCC4MTridN8TzXXe8oys87WlSpIH/uqIQG6vkE2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBaU+zIqSDz94XMb7ZmZl6RzswLRBRJRMXXCsmmRsUVFWIp02x/kXyCFZn45yEUEhlK7z605yTkVGbYi03cPC0rDhab2KYe9ayjHvCxv86Y5hZ2Ayrqh2sAJ6CqJyeGTKgvq9BYeLydJDwz8jvx0EZJLbblha1Ep+ncPgmeuqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ/ssfqy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ/ssfqy"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60110772so1618427b3.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755107479; x=1755712279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dh1QflHOymZgEtMjaDm2rdqQip1fNB/4MxPM2RRlp0=;
        b=lQ/ssfqyeXMPwz08Y8BSOmSJV3qQw1qLWQ7Q57aFInFhZbokfwjfrDaaS4KhTgRu0d
         eSkmNd4vnXtxerIgkMvO2wyhz/X+JdpLeoHIt7hClDmDy3pkIucEG8+D+ZRi6Vroaqby
         /N12xIa3uE8r/HLwpyeLErkpVqvzZ4vxXIvXM5ao5oWpZcpmqal7CpN0OIOAgCl4FRNu
         W87jPG4A7Je1eSEm16C9TbKlOzg3x7vN2VR6ZV51prtV6qDQqZveOpkikQQivK4qFWem
         zLG2H9oPbaCfakjWPYH9s8NqQoNVK07evr5bOWhTLZChbGuZeybaxloui9Iga9EQLj8/
         bElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107479; x=1755712279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Dh1QflHOymZgEtMjaDm2rdqQip1fNB/4MxPM2RRlp0=;
        b=QVEZOjCf4l7xWlLc2ZwpyNvKvHXX/SvFA41csieSafWc/dBEvSBNHmudS/mpBnhIye
         opVG7p8WrrrgY1htyvqkMcuIUsCDb7VRfJslJQzTY8xEy3IbtmyVHe1NLEPHLi8yv9C8
         hq37D3X+F4OO7l+cOexux/QcNkhfgt76w9yfJDhmRVEGIF0g4LzEovPDtJzi85D5ts8S
         ZzUKKVqTHZho4/vScxoHvbf9ssiSh7Zn0rpFdnglGLitOvZ+lEs4KNQuWjBD56YDKc3D
         CihNgd/Bk/Z37/fvXF+3bJmITt8TXz/Bpr2zxWvnvZCRmzluIkzpTokEPvuP+B1QT655
         I3dw==
X-Gm-Message-State: AOJu0Yyhk9bW848CGrfLVD/HTuZcx1RA6v05fd4WT5Yh+u1tOpN/tzUH
	PeMyrnsZOlmlmUXhF4VZXOp8HQP5o/wkMwoOusEuW4HUlhcSZcHvTe1RGLsbzKki
X-Gm-Gg: ASbGncug3ojIM1OClM1bN1+6u6O+gxBXysBBIgpKJgHutgZZ5BmgUkDiqJBDA105KNv
	CUOUpyQC4vOH+r7H2dBwjPtS+ofLzd2P0+dB0EQpP07nOh9lS0wdi0xqfDByGU05nCkxVicrkIR
	czyy9Rxa5qkasDovjhYR7Jqc0R4qVRvy0cZeorgbE/bzF+dRFHnK+oUQWzUepQLGxKmxA1UhG4G
	VV/jmehBTfY36H039x43Dv6liTLDIabIBqfkxPhMX/utquQxWqpfkSDIkVpktei62rSI2upyV1b
	NbZ6V/b9jYvnkri0K5H4Q8CWtAohQss+qeTIFXmCIdtkMXqjxDuBpapJO2rbYiK+TFyw0ohH6u1
	9qhYmGpIOL8NLhWbRE2cc6ju4wUCY5x7LbBElWijYKIjQrEYMbtzZJqwwgaCjlPjQXjVUX95U
X-Google-Smtp-Source: AGHT+IHZrK3vmDj4yn48hxvqYdfwv+4qGeabtE6xCIQXMs/IwQ8g+siGCEx6QHqpT6os8x1cN5b43w==
X-Received: by 2002:a05:690c:a86:b0:71d:4b52:6f77 with SMTP id 00721157ae682-71d4e3f6146mr53546707b3.9.1755107474679;
        Wed, 13 Aug 2025 10:51:14 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:1c37:18b4:a0bf:d7d3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71d60fe1936sm439957b3.38.2025.08.13.10.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:51:14 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 0/3] clean up some code around editors
Date: Wed, 13 Aug 2025 13:50:02 -0400
Message-ID: <20250813175112.88435-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250812170256.71751-1-ben.knoble+github@gmail.com>
References: <20250812170256.71751-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v4:
- revert use of test_env: fix the one instance that needs adjusted for
  VAR=val cmd syntax by using test_must_fail env VAR=val cmd.

Changes from v3:
- drop 4/4
- use test_env (including a case our lint does not catch when the value
  has spaces)

Changes from v2:
- shuffle setup code and use more helpers in 1/4
- insert 2/4 to stop abusing --exec-path
- improve environment-cleansing idioms in {2 => 3}/4

Thanks especially to Phillip's encyclopaedic knowledge of test helpers ;)

Changes from v1:
- add a prep patch with style fixes to t7005
- rework the environment munging to use subshells, per Phillip Wood's
  suggestion

These patches clean up some old code in the editor tests that does not use our
modern idioms.

Also, this version is (still) based on a later master 112648dd6b (Merge
branch 'master' of https://github.com/j6t/git-gui, 2025-08-04) than the
original from May.

v1: https://lore.kernel.org/git/20250520193506.95199-1-ben.knoble+github@gmail.com/
v2: https://lore.kernel.org/git/20250810160323.49372-1-ben.knoble+github@gmail.com/
v3: https://lore.kernel.org/git/20250811221706.67168-1-ben.knoble+github@gmail.com/
v4: https://lore.kernel.org/git/20250812170256.71751-1-ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/tree/editor-cleanup

D. Ben Knoble (3):
  t7005: use modern test style
  t7005: stop abusing --exec-path
  t7005: sanitize test environment for subsequent tests

 t/t7005-editor.sh | 147 +++++++++++++++++++---------------------------
 1 file changed, 59 insertions(+), 88 deletions(-)

Diff-intervalle contre v4 :
1:  8ad2904a18 = 1:  8ad2904a18 t7005: use modern test style
2:  44a6fd8eb3 ! 2:  5a35889571 t7005: stop abusing --exec-path
    @@ t/t7005-editor.sh
      	esac
      	test_expect_success "Using $i" '
     -		git --exec-path=. commit --amend &&
    -+		test_env PATH="$PWD:$PATH" git commit --amend &&
    ++		PATH="$PWD:$PATH" git commit --amend &&
      		test_commit_message HEAD expect
      	'
      done
    @@ t/t7005-editor.sh
      	esac
      	test_expect_success "Using $i (override)" '
     -		git --exec-path=. commit --amend &&
    -+		test_env PATH="$PWD:$PATH" git commit --amend &&
    ++		PATH="$PWD:$PATH" git commit --amend &&
      		test_commit_message HEAD expect
      	'
      done
3:  135d4368d6 ! 3:  e6e31ab98c t7005: sanitize test environment for subsequent tests
    @@ t/t7005-editor.sh
     -export TERM
      test_expect_success 'dumb should error out when falling back on vi' '
     -	test_must_fail git commit --amend
    -+	test_env TERM=dumb test_must_fail git commit --amend
    ++	test_must_fail env TERM=dumb git commit --amend
      '
      
      test_expect_success 'dumb should prefer EDITOR to VISUAL' '
    @@ t/t7005-editor.sh
     -	VISUAL=./e-VISUAL.sh &&
     -	export EDITOR VISUAL &&
     -	git commit --amend &&
    -+	test_env TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
    ++	TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
     +		git commit --amend &&
      	test_commit_message HEAD -m "Edited by EDITOR"
      '
    @@ t/t7005-editor.sh
     -		;;
     -	esac
      	test_expect_success "Using $i" '
    --		test_env PATH="$PWD:$PATH" git commit --amend &&
    +-		PATH="$PWD:$PATH" git commit --amend &&
     -		test_commit_message HEAD expect
     +		if test "$i" = core_editor
     +		then
    @@ t/t7005-editor.sh
     +				export $i
     +				;;
     +			esac &&
    -+			test_env PATH="$PWD:$PATH" TERM=vt100 git commit --amend
    ++			PATH="$PWD:$PATH" TERM=vt100 git commit --amend
     +		) &&
     +		test_commit_message HEAD -m "Edited by $i"
      	'
    @@ t/t7005-editor.sh
     -		;;
     -	esac
     -	test_expect_success "Using $i (override)" '
    --		test_env PATH="$PWD:$PATH" git commit --amend &&
    +-		PATH="$PWD:$PATH" git commit --amend &&
     -		test_commit_message HEAD expect
     -	'
     -done
    @@ t/t7005-editor.sh
     +				export $i
     +				;;
     +			esac &&
    -+			test_env PATH="$PWD:$PATH" git commit --amend &&
    ++			PATH="$PWD:$PATH" git commit --amend &&
     +			test_commit_message HEAD expect || exit 1
     +		done
     +	)
    @@ t/t7005-editor.sh
      
      test_expect_success 'editor with a space' '
      	echo "echo space >\"\$1\"" >"e space.sh" &&
    - 	chmod a+x "e space.sh" &&
    --	GIT_EDITOR="./e\ space.sh" git commit --amend &&
    -+	test_env GIT_EDITOR="./e\ space.sh" git commit --amend &&
    +@@
      	test_commit_message HEAD -m space
      '
      

base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
-- 
2.48.1

