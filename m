Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3011499F0C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965503; cv=none; b=uc2tQtF0TqaxhR0JTw/mZXcCj9BB52e3HD4p5cueLi0bHDlRQ23EHI53Ypy38EfPXa4gmFWntilMmxOox1k4Z3vm4nRbsVf4zm9NmkDdc2GtOkRr6O8yJd+2+VCfSuk5ihF82EkOYpmRAGTMXK8uy84tI336mQIHruCKb+YrU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965503; c=relaxed/simple;
	bh=tvI4xUxFCcDH4lTiR0AgEc0RgQ190Rl1+MpQs7N2tsg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=MYxS7i5I9fwlqT5ryxoNIPQ/DEr5sxAmLVub4FFLXpmZIaoPaY4OYSmtmYCfYMC1tIrmCsCzgqBDH0tV70kRxIEcJICH4VmWOYYdLE8L+7rYVijPd1RyVHNsQKH/XEBTrHraYedl1c5mIsCvI9fkdEHn69oL4ksTDF/Be13rchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu2xdfxD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu2xdfxD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so70071595e9.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965499; x=1789570299; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JSNUBKmRR8QoSY8+syKkcdtMcukkZ52Hr/h93dHuc8=;
        b=Yu2xdfxDfnJQdjD9xVMQWUbGDc/LMNcaEvAjrFdMhXEqMdkz/eNgl5Yx+xE2e+8MJC
         8UhC/O33qOx6CX4LJyTdNeShW+LE/eVl4S9aKVt48ogpAH25yA/Oqc5QiA4hDoGicWGw
         SShnm8fz1OiuXyGkbCFed4/+hagzk3Dglhx9q5RDGvAFwdrMsqDgMZHklnDrHwLvIqpN
         w4rE7vFABC/q/cQlivaU8azlEMIZSy0ozaSNg7bASQOtfckZrppTf+B/SMxcs5fp/duS
         GxcuZAIz8TNaTi4VzUtJs8fFQ5N9+HBl99Prw8v7bDsTTI5+1ddJpiONJEuROCx7hAC/
         99tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965499; x=1789570299;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JSNUBKmRR8QoSY8+syKkcdtMcukkZ52Hr/h93dHuc8=;
        b=Efeu6GodtsgKa4E4+FfCPr2vTOnzzx0g+m93TCRN0Q4V42oXnxIdVjDIp6vRC+nWap
         RX7+Aw2lHX1ewGAB5tm/wqn4xjOfa4a6WkMubsUhgRgGCuPAndkRvPnHZqu/qB7WZHRx
         zad96Ayhu61hYqm/A5+TqG885H6P7dUQ6lM4xclMaK3fX2umTuBYCNgrB5KkDDcytS7D
         p+XoiMiqv9ZHb5Ex50Tt0jBocAsL730781siJCETKweyIK8CpXJ/42KQp+fRbWTvlDUb
         +obTBe2zdnCZEKxfVVmd8FDhdjIqIrlsRXV5C2wboIp3E9H6Xakf2j01kq7wRREoSmhS
         KiCA==
X-Gm-Message-State: AFuF++nBszyR8TsguZfbMDf1KdEKvgElZsBd38xq56Eog6KQCGgfG1RK
	e/dZvF1Zygl3BnzqVH8xXlb/njlAPK9V1WvpFz+Xkp3rmO2uaHBS0HpjSlU2qg==
X-Gm-Gg: AYBFou1+82XA1XMPpkzhyaLbHF6wf3KzWlB+0ICcVF/ANoagoHSsWfFoRmOng8ksFbe
	6lccFvxLxUkG1CestxuCoNTkCZUmgDjU+lZShwdnCW67dLBvbeJtHLnG6tigN3K/7/UAitaOyIt
	ug+77aImvCUXhJph7qZ9/H2rZgbcC3jytko/nqh+V9EdvzVOd3WLEOYl9U/62BvLXNdVqjJwXfk
	9HkVWVMjm0rKBUH7qVkiRUkaDCumTJkNy9fFzjV9TQ5KiDBH8jOHaZq/y165CjFAA07c217dcL6
	cSTeTcOi5BvtidOFE+jF0UhlRL8HBfBCd3Gr6WquxE24Ujqk0bYxaRKq/UVvc72YIKSBsKzfzNm
	Q0YlT7t3iyMxSGmMt+cBcXe/VMMYyalUlegrsEimNH63ZRZ+5DSAVy2fs4gatYM2nZXE7YIm83p
	SUs+F2jL4m98186mV66pI9P6uOvywOGztmhSEnW+xRvVzlvWHR6gW6bLkz+G5U73GNsEApTcMb3
	+lwHDTmgANrAMmoRfQQkcfxEdGgNUvx0gdlDA==
X-Received: by 2002:a05:600d:8481:20b0:49c:fde6:8b39 with SMTP id 5b1f17b1804b1-49cfde68bacmr235578765e9.29.1788965499224;
        Wed, 09 Sep 2026 07:51:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:a4c9:a6b9:39b9:91bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm661451095e9.13.2026.09.09.07.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:51:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 0/4] hook: introduce the receive-report hook
Date: Wed, 09 Sep 2026 16:51:35 +0200
Message-Id: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23RzU7EIBAH8FfZcBbDR4HBk+9hPAAddlG3mLbba
 DZ9d2GNsVaOkwy//zBzJROOCSfycLiSEZc0pTyUwt4dSDi54Yg09aUmggnNgAtqFNA0zGPuLwH
 pKedXqrx00UbuDAIpD99HjOnjhj49f9fTxb9gmKtUO05pmvP4eUtdeO37CYBWwMIpp+CgB4tag
 YTH49mlt/uQz6QGLGJDCN4kRCHQMhTRuCBC3BNyS3RNQlJGO2uV0JE5psWe6LaEbhJdIbTnnTX
 K9VaZPaF+CcvaH1GFkCr0QXuUIfA9obeEbBK6TiFAeh699TzsCbMl2rswlQi6bkI6Zf7tArZE+
 6hQCI8AThvukP+5yLquXxKdkwybAgAA
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5655; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=tvI4xUxFCcDH4lTiR0AgEc0RgQ190Rl1+MpQs7N2tsg=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGqhcnmgRGyfaOXuFpGObSvyiPMPRsx3PvtCphjUXYzCC0cEQ
 4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqoXJ5AAoJED7VnySORox/hlsL/Avt
 WvKJm5E4rMM17wtSFCh0qjXcbHfr8HJL8BhxYGIz87lp9/gcOCg8LNyoq+7PSGqQpPKLl/mC10w
 Kngs5MPUbuOFSL7yJUQLoxkkPpRd3SVJXpa4IC02+9JSeowFIxDtgQ0amxvyiCnS8oEiWDVpMTX
 8/+T83N/rZFK/+Gz7uQD+42AqEoSFgUl8pXIiv2K3sVgvnTiPK7u87LfoGrI/6zYRXn4lnK1xIB
 X8RbodGn4+i3rL/kaypjOBYm3ZUprzyvsrzsqqU9+x/EsPjhlzjRT0o9fZ9YV0UwG2dfEOuo4yF
 SUQ94zcCEpJY6R6D9FY4fajRiybE3rLp0+isFCyUta9dNj2RKE1u+LG7ar2j5NE6XEgCSwlROVI
 thhZ90oujWTECdfsrZD7HPxf6ndJGTsX8eNp9RSpPNkoHQYClHY2zH1Z8K9znnIYAT4EnE/QFG/
 l1YbNjR2kavS2g2VEKaNO5buXMiemyarEJgn9iNK91y0e4A5pfkx+SwspT3w==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a new receive-report hook which kicks in after the reference
transaction is complete, but before the report is sent to the client.
The hook receives the pkt-line encoded report in its stdin and its
stdout replaces the report transferred to the user. If the hook exits
with a non-zero exit code, all references are marked as rejected.

The first patch, adds missing documentation to 'git-receive-pack.adoc'.
The second patch refactors code and the third patch contains the new
hook.

---
Changes in v9:
- Fix a bug where we were causing a BUG() when no report was requested.
  It is perfectly valid for clients to skip the report and we shouldn't
  fail when they do so. Thanks Junio!
- Link to v8: https://patch.msgid.link/20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com

Changes in v8:
- Fix spelling mistake s/UNKOWN/UNKNOWN
- Remove a stale comment from previous version.
- Fix an argument which wasn't changed with the previous version's
  changes.
- Link to v7: https://patch.msgid.link/20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com

Changes in v7:
- Removed report_v2() since it is the same as report() with the new
  changes.
- Used a switch statement instead of an if/else for the enum.
- Removed an unnecessary curly brace.
- Also rebased on top of latest master (3cb9185f65 (The 22nd batch,
  2026-09-02) as there were conflicts.
- Link to v6: https://patch.msgid.link/20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com

Changes in v6:
- Introduce a new commit which introduces `enum report_status_version`,
  use that and drop static variables in the codebase.
- Reword the commit message and documentation to:
  - State further why reference-transaction cannot be used.
  - State the responsibility of the hook owner to undo and reference
    changes if needed.
- Link to v5: https://patch.msgid.link/20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com

Changes in v5:
- Rewrote some of the commit messages and documentation.
- Renamed the function `generate_response` to `generate_report` to avoid
  ambiguity.
- We now override the cmd's error_strings, this avoids the whole
  precedence issue with the earlier series.
- Also add information about how we can override the unpack status to
  fail the push and add a corresponding test.
- Thanks to Patrick for the review!
- Junio: This causes conflict with next ('jt/receive-pack-pluggable-writes')
  similar to before, please let me know if its better for me to add that
  dependency.
- Link to v4: https://patch.msgid.link/20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com

Changes in v4:
- Change the name of the hook to be 'receive-report' to avoid ambiguity.
- Link to v3: https://patch.msgid.link/20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com

Changes in v3:
- Move out addition of proc-receive hook doc to 'git-receive-pack.adoc'
  into a new commit.
- Add a new commit to move out the response generation in receive-pack
  to a new function.
- Instead of die-ing on non-zero exit code, we modify each reference to
  indicate that the hook failed.
- Instead of correctly listing out the protocol, link to
  linkgit:gitprotocol-pack[5], as the protocol also differs between v1
  and v2.
- Link to v2: https://patch.msgid.link/20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com

Changes in v2:
- Modify the documentation and commit message to be more verbose.
- Add documentation to 'git-receive-pack.adoc'
- Use 'ret' as the variable name for the return code.
- Modify the test to also check for the 'remote:'.
- Link to v1: https://patch.msgid.link/20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com

 To: git@vger.kernel.org
 CC: ps@pks.im
 CC: gitster@pobox.com
 CC: jltobler@gmail.com
 CC: kristofferhaugsbakk@fastmail.com
 CC: phillip.wood123@gmail.com

---
Karthik Nayak (4):
      doc: add proc-receive hook info in 'git-receive-pack.adoc'
      receive-pack: drop static variables to track report status version
      receive-pack: move message generation to separate function
      hook: introduce the receive-report hook

 Documentation/git-receive-pack.adoc |  17 +++
 Documentation/githooks.adoc         |  61 ++++++++++
 builtin/receive-pack.c              | 146 +++++++++++++++--------
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 224 ++++++++++++++++++++++++++++++++++++
 5 files changed, 401 insertions(+), 48 deletions(-)

Range-diff versus v8:

1:  c6a3771d9c = 1:  4c9a431c76 doc: add proc-receive hook info in 'git-receive-pack.adoc'
2:  427d2ac58c ! 2:  2f86f33735 receive-pack: drop static variables to track report status version
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
     +		case REPORT_STATUS_V0:
      			report(commands, &unpack_status);
     +			break;
    -+		default:
    -+			BUG("unknown report status version");
    ++		case REPORT_STATUS_UNKNOWN:
    ++			break;
     +		}
     +
      		sigchain_pop(SIGPIPE);
3:  b0d2b63432 ! 3:  469d692696 receive-pack: move message generation to separate function
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
     -			report(commands, &unpack_status);
     +			report(commands, &unpack_status, version);
      			break;
    - 		default:
    - 			BUG("unknown report status version");
    + 		case REPORT_STATUS_UNKNOWN:
    + 			break;
4:  eca9cb06a4 = 4:  0ea2855658 hook: introduce the receive-report hook

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

