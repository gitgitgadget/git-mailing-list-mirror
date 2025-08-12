Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3278F51
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018181; cv=none; b=M9lNGlCJx6dXsO2HaROxREQOD2bXvnoyC5yARUtZ0u4LQiGJqJn/rVbRTpxjZmeO5gGPigDBXd62HRq3ZQJFoqvOtcElDnI5UCEY4skkbvU9Do/A1s6/4dwrZAPcspP7spNlSl6qgscXsDzC0jiJovvXdnmTHtk0eQIk3A65MA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018181; c=relaxed/simple;
	bh=oklf7WD/AzOgJwf7udBjx3q72LkMM0pX4XaiDVeqS2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lar4ZYoqVSEMLZDA3ShY6kD0qhxH3jVKmADjrKNzuh7X9Bqst9uQrDAHcDLbypw4P5YCeUqVYWaoQcYkyUEwv/VQfYWkg//yVpSmElAie+CfoEVEuODiqOF+bvny/BpOFrbEkUhk/g+A9bZ2CyOwtyBtTXOAaAo69xiVAVJTHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM4IxOzW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM4IxOzW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71c075c3756so20863237b3.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018179; x=1755622979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs+gz9YgrQxEObcp+v/PJvucVuaAuircOKCOdbe8e3c=;
        b=gM4IxOzWbyBoy97UOsWIjEULeLxS7kAsAEuWIs0WziFD+IvLrXY0Rpwgbr82zs+Y6Q
         0Q2h3G1Rmwi3BfRNtQNylx0bygJt+X2Az19OjQfezwd//x/oos1CaN2GNKvOR34e7vMU
         9hMYdGXWfz+l4E+Ofq29NVVLPDpbjtPGjLPcv2co7eCbtVKSCum9uhEU/An2d9+16/Vg
         3luzutA6nJjQms75AisMgpiw9TUnH9gFpsLCoWBIQOqOrZssvMvZt3DVgV1+cMkBx/6T
         Puz8mPXyVNdYxCFakw5G+Q+rV2HWMjXAw4NpW8yIF7CoBFnpdzDE0verpBQ89AHw/dle
         +L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018179; x=1755622979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zs+gz9YgrQxEObcp+v/PJvucVuaAuircOKCOdbe8e3c=;
        b=GSUeGdHCyrD6ZHdbi1rQlgJYjIBVu8eYIWiBNrydVtkXAcsvth6ooaAvrJJC6eeFKk
         4BZ5ehpYnw6FkkEK9QKrAz/IX3TS1MpND7ZP/euVKB+gc84Bl8pIaioG095K/TjewmlU
         FjYdbe3Dem4sWNbxQT91KulIvv1T4hgah8vAh7KIZpf2R9aGUY5AMn0aIEtpc+W5Bx+v
         HmKB0Q0UyLjCz7f5R7F1ngMTyOPyu0dzExWQcBO5F7M1ta15Jpl86iXamvt7CAxEHf4Z
         3Ohb9Kyu0rjB8eV0ESrBEDcJCNkOzkFp8mYiKfFPbeoxUXgvXmJXl/V7TkfF7dXEPepI
         jW/A==
X-Gm-Message-State: AOJu0YzP6ESCRX07GtJNwMwzc+WnnsB1+GLidgGyBkOTE9LHaSeHYoOC
	vmW/o/6/I/4HwTw+Sk6pPMbPXsHUoh8o2wFN9XCuabaupcjS8W5uqJIQDo9b80JA
X-Gm-Gg: ASbGnctH8W4sCLLzI13gGOtz3TNyObUQQ71y51h083Dr+ojqB2kRdpZOEvbCSUcBENE
	xdt0KC8k/vW8Y8R2QPHwQrzIz70ZvzziiJAUHr/OVO4PsBpyBAH8DsKzm1DplUbrGnhn1aeonwF
	bvgdHYzjnGu8LigpXlaMQgQhDNx6DfND715ywF6fPDRbNT5sevFSxkF4kqTBT4MlawQmE3lFOEP
	x/JmR6qOFoAFKKd2X9BL+Dz+6CY3uRWTfUyjOwbsodBy9WgAaaHHnucBmSF/BH9sST9yNpEgPE0
	8jAgduMiT/gjhrbIrAt5UdS4rcUbsZNZiVCvVHIflBmVKOmy1V87y7sjGzkt42J30G4FmmUpYT/
	McN2AlOeV+5RVcbgCcXxl910oP88KEO1tw3yJxyC5QgIWEL3EYJ7jEVTioC0S10M2m8S3O7FRgM
	w=
X-Google-Smtp-Source: AGHT+IEmFD/Re6Qs5N5MWux5vX/09IqlpRMQTjKcDySCmN+u6QI1l28i0dAdccQngRkACsznA0czZg==
X-Received: by 2002:a05:690c:64c2:b0:71a:4325:a182 with SMTP id 00721157ae682-71d4ce22d92mr4282537b3.24.1755018178484;
        Tue, 12 Aug 2025 10:02:58 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:b54a:f21:a9f:3c85])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f6cfdsm76960927b3.24.2025.08.12.10.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:02:58 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/3] clean up some code around editors
Date: Tue, 12 Aug 2025 13:02:15 -0400
Message-ID: <20250812170256.71751-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811221706.67168-1-ben.knoble+github@gmail.com>
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

This reroll of the previous exec-path series is simplified to contain
only the first 2 cleanup patches, which were largely acked by the list.
Drop the controversial and broken PATH munging.

Also, this version is (still) based on a later master 112648dd6b (Merge
branch 'master' of https://github.com/j6t/git-gui, 2025-08-04) than the
original from May.

These patches clean up some old code in the editor tests and subsystem
that does not use our modern idioms.

v1: https://lore.kernel.org/git/20250520193506.95199-1-ben.knoble+github@gmail.com/
v2: https://lore.kernel.org/git/20250810160323.49372-1-ben.knoble+github@gmail.com/
v3: https://lore.kernel.org/git/20250811221706.67168-1-ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/tree/editor-cleanup

D. Ben Knoble (3):
  t7005: use modern test style
  t7005: stop abusing --exec-path
  t7005: sanitize test environment for subsequent tests

 t/t7005-editor.sh | 149 +++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 89 deletions(-)

Diff-intervalle contre v3 :
1:  8ad2904a18 = 1:  8ad2904a18 t7005: use modern test style
2:  9451e4f0f6 ! 2:  44a6fd8eb3 t7005: stop abusing --exec-path
    @@ t/t7005-editor.sh
      	esac
      	test_expect_success "Using $i" '
     -		git --exec-path=. commit --amend &&
    -+		PATH="$PWD:$PATH" git commit --amend &&
    ++		test_env PATH="$PWD:$PATH" git commit --amend &&
      		test_commit_message HEAD expect
      	'
      done
    @@ t/t7005-editor.sh
      	esac
      	test_expect_success "Using $i (override)" '
     -		git --exec-path=. commit --amend &&
    -+		PATH="$PWD:$PATH" git commit --amend &&
    ++		test_env PATH="$PWD:$PATH" git commit --amend &&
      		test_commit_message HEAD expect
      	'
      done
3:  61cb116780 ! 3:  135d4368d6 t7005: sanitize test environment for subsequent tests
    @@ t/t7005-editor.sh
     -export TERM
      test_expect_success 'dumb should error out when falling back on vi' '
     -	test_must_fail git commit --amend
    -+	TERM=dumb test_must_fail git commit --amend
    ++	test_env TERM=dumb test_must_fail git commit --amend
      '
      
      test_expect_success 'dumb should prefer EDITOR to VISUAL' '
    @@ t/t7005-editor.sh
     -	VISUAL=./e-VISUAL.sh &&
     -	export EDITOR VISUAL &&
     -	git commit --amend &&
    -+	TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
    ++	test_env TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
     +		git commit --amend &&
      	test_commit_message HEAD -m "Edited by EDITOR"
      '
    @@ t/t7005-editor.sh
     -		;;
     -	esac
      	test_expect_success "Using $i" '
    --		PATH="$PWD:$PATH" git commit --amend &&
    +-		test_env PATH="$PWD:$PATH" git commit --amend &&
     -		test_commit_message HEAD expect
     +		if test "$i" = core_editor
     +		then
    @@ t/t7005-editor.sh
     +				export $i
     +				;;
     +			esac &&
    -+			PATH="$PWD:$PATH" TERM=vt100 git commit --amend
    ++			test_env PATH="$PWD:$PATH" TERM=vt100 git commit --amend
     +		) &&
     +		test_commit_message HEAD -m "Edited by $i"
      	'
    @@ t/t7005-editor.sh
     -		;;
     -	esac
     -	test_expect_success "Using $i (override)" '
    --		PATH="$PWD:$PATH" git commit --amend &&
    +-		test_env PATH="$PWD:$PATH" git commit --amend &&
     -		test_commit_message HEAD expect
     -	'
     -done
    @@ t/t7005-editor.sh
     +				export $i
     +				;;
     +			esac &&
    -+			PATH="$PWD:$PATH" git commit --amend &&
    ++			test_env PATH="$PWD:$PATH" git commit --amend &&
     +			test_commit_message HEAD expect || exit 1
     +		done
     +	)
    @@ t/t7005-editor.sh
      
      test_expect_success 'editor with a space' '
      	echo "echo space >\"\$1\"" >"e space.sh" &&
    -@@
    + 	chmod a+x "e space.sh" &&
    +-	GIT_EDITOR="./e\ space.sh" git commit --amend &&
    ++	test_env GIT_EDITOR="./e\ space.sh" git commit --amend &&
      	test_commit_message HEAD -m space
      '
      
4:  ea269f2442 < -:  ---------- editor: use standard strvec API to receive environment for external editors

base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
-- 
2.48.1

