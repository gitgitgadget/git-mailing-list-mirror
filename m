Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F651CDFCC
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736115213; cv=none; b=h3+Hpd4bMXLXx89muQmC3qh6M2kCC7lTQhnCZ+PaemLoHxHaHvN20OJZ9SeISaMvLluY2TvQhp6UXVpGik6mvmXWZAIShqN6hR6M13IQVlW6hSLuKQ+ploaHBx7cjaH6tFgvY65EvOc9GjoZ2gfhRqE0WacbDLAF7WKkSAOAbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736115213; c=relaxed/simple;
	bh=Cu1osOW8peSgScoIHQBfo1MhZ3/PGjsfmwY1L4nGmNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV9GF0vMVP4Tr4GCK7woACVe9FmeOGHhyEXpg9eS9uhpkFn3+YoY/LQ6Hb5P81HT/KyQOvh+uqbvcy9mA2CytnBtGUvoapHXsbK5VBH9L/qQ73nRRiQD4WzIh4LBOfHxSGHWgswzDsyv/vjvayUfhWill79CNJWQ1+Wp9BWvycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saville.com; spf=none smtp.mailfrom=saville.com; dkim=pass (2048-bit key) header.d=saville-com.20230601.gappssmtp.com header.i=@saville-com.20230601.gappssmtp.com header.b=RhlJ0FA+; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saville.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=saville.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=saville-com.20230601.gappssmtp.com header.i=@saville-com.20230601.gappssmtp.com header.b="RhlJ0FA+"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so15040500276.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20230601.gappssmtp.com; s=20230601; t=1736115210; x=1736720010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu1osOW8peSgScoIHQBfo1MhZ3/PGjsfmwY1L4nGmNE=;
        b=RhlJ0FA++p1cUrB6cfm4Q4YNPSJikXnrmtAAbzTQBCTXPnOVh3BNtageVcxvkotrWV
         /pOa9BpSkOlpLYZlHBO0yRH+99JiB08Qle/l7wj0+2SwqdTo9SfxafaOVkoNib0HhulJ
         CurIyyeTQ3oH5eZb80jCY7LN5jnYi2YZ1D3XPTdh1S1hQxmXxhHHT72Udh11BbfTwGsU
         7DWmCbpQGditngAKEsHcWl1V3tTDYahJdPgDFZniT6V1pm5fmV87sMDPyfjMfI45pOm3
         bRQA/y8yGMjOQjrN8Ykj3JLNVUeto2ln6vG1z+seVujubx+w0/L9Ni2WidE+vPEJL4VW
         FbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736115210; x=1736720010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cu1osOW8peSgScoIHQBfo1MhZ3/PGjsfmwY1L4nGmNE=;
        b=YEe1DaPVgxadIlue2IfQMf5LkiqbJq47fpHVMwm7HXKyZtCULmie5wdYMUcOWh40H4
         +Og9/Xe5/tGxvVFCyQeslrLWH+KdBhqoOdkuhmr1l2Jt1bjZv5jqxZQgvhHbPhjy+VbF
         diuOZ8JSn8K6jl30Os//Y8nKqaBfBGATIQkgWAum3efF6u/9ZkYY4cLA03ULlECcfl+s
         1CSjA8e6mjvwfFbQnVqcTBTvayPidRydbKpD80R12Bw6UPOUX0ZdXAIkIgJtS0b/QS+q
         rWHWqmkU3eVcg+zvXQ7btwkeQrDb5YfLSnHhjkzEMbKDcsUHd92YEklS6XTuxqMS5MFv
         9N+A==
X-Forwarded-Encrypted: i=1; AJvYcCWQE76XloykG8PxQq9sIeoBmO3wmM6Emwjwte3hMvqOmzU82co+R2z1NW+Ryk3/nNC3yUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HDwHo9WYaeOa1SI6nCK9zVdSrBieAmMoN43j3Fe1+VBZHPaZ
	2CF6ShOnk2VzaqBK03NfV+xkrZVI3NnSKvQr21MZ+ILsSc1lomc9xtAwugkyL/90D7lrzjQuIrW
	gJCUM0ObNGMwiODVFobGeYIAz/46r7mc+AwrfXQ==
X-Gm-Gg: ASbGncu50r4sRhjGoxd1iko8hZ+S2QMTX1vBkNMSaaBUEykS8EScNOrWIA8y+iGffie
	97WoR5Hhc+qE3K/EvcCmKLMBs3Rs1SV6pIV1aq9E=
X-Google-Smtp-Source: AGHT+IGF4wBao2nkJlOFUADCNdhy2Ldn6zv2siOURvmJeolm1s8guhpEJ0Zmylk05/Ep3GZ3+ltcHZk9jfS63n6JWlc=
X-Received: by 2002:a05:6902:2082:b0:e30:dbda:de2f with SMTP id
 3f1490d57ef6-e538c4026f9mr36720611276.39.1736115210026; Sun, 05 Jan 2025
 14:13:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
 <20250103204624.GE3212696@coredump.intra.peff.net> <CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>
 <20250104003154.GB3244554@coredump.intra.peff.net> <xmqq4j2fnv8p.fsf@gitster.g>
 <20250104033210.GA892381@coredump.intra.peff.net> <CAKk8isrRCZsrt=2YB+L3EjK3ZAYbSk0e+1YZexqZUhB78L36dg@mail.gmail.com>
In-Reply-To: <CAKk8isrRCZsrt=2YB+L3EjK3ZAYbSk0e+1YZexqZUhB78L36dg@mail.gmail.com>
From: Wink Saville <wink@saville.com>
Date: Sun, 5 Jan 2025 14:13:18 -0800
Message-ID: <CAKk8isoPDcHJXm6HL1x4knNATWsy9mhPXTN5-P-rgFyUfZruDw@mail.gmail.com>
Subject: Re: [BUGREPORT] git diff-tree --cc SEGFAUTs
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000627409062afcd2f0"

--000000000000627409062afcd2f0
Content-Type: text/plain; charset="UTF-8"

I'd like to suggest one minor tweak to Peff's change. Rather than just
changing the type of combine_diff_parent::path to `char *` I like to suggest
changing the name and adding a comment. My inclination is to use
`changed_path` as the field name.

The resulting diff against next is attached.

--000000000000627409062afcd2f0
Content-Type: text/x-patch; charset="US-ASCII"; name="wink-changed_path.diff"
Content-Disposition: attachment; filename="wink-changed_path.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m5k6306i0>
X-Attachment-Id: f_m5k6306i0

ZGlmZiAtLWdpdCBhL2NvbWJpbmUtZGlmZi5jIGIvY29tYmluZS1kaWZmLmMKaW5kZXggNjQxYmM5
MmRiZC4uYmU1ZGYxOGQ3NSAxMDA2NDQKLS0tIGEvY29tYmluZS1kaWZmLmMKKysrIGIvY29tYmlu
ZS1kaWZmLmMKQEAgLTY2LDEzICs2Niw5IEBAIHN0YXRpYyBzdHJ1Y3QgY29tYmluZV9kaWZmX3Bh
dGggKmludGVyc2VjdF9wYXRocygKIAkJCW9pZGNweSgmcC0+cGFyZW50W25dLm9pZCwgJnEtPnF1
ZXVlW2ldLT5vbmUtPm9pZCk7CiAJCQlwLT5wYXJlbnRbbl0ubW9kZSA9IHEtPnF1ZXVlW2ldLT5v
bmUtPm1vZGU7CiAJCQlwLT5wYXJlbnRbbl0uc3RhdHVzID0gcS0+cXVldWVbaV0tPnN0YXR1czsK
LQotCQkJaWYgKGNvbWJpbmVkX2FsbF9wYXRocyAmJgotCQkJICAgIGZpbGVuYW1lX2NoYW5nZWQo
cC0+cGFyZW50W25dLnN0YXR1cykpIHsKLQkJCQlzdHJidWZfaW5pdCgmcC0+cGFyZW50W25dLnBh
dGgsIDApOwotCQkJCXN0cmJ1Zl9hZGRzdHIoJnAtPnBhcmVudFtuXS5wYXRoLAotCQkJCQkgICAg
ICBxLT5xdWV1ZVtpXS0+b25lLT5wYXRoKTsKLQkJCX0KKwkJCXAtPnBhcmVudFtuXS5jaGFuZ2Vk
X3BhdGggPSBjb21iaW5lZF9hbGxfcGF0aHMgJiYKKwkJCQkJICAgIGZpbGVuYW1lX2NoYW5nZWQo
cC0+cGFyZW50W25dLnN0YXR1cykgPworCQkJCQkgICAgeHN0cmR1cChxLT5xdWV1ZVtpXS0+b25l
LT5wYXRoKSA6IE5VTEw7CiAJCQkqdGFpbCA9IHA7CiAJCQl0YWlsID0gJnAtPm5leHQ7CiAJCX0K
QEAgLTkyLDkgKzg4LDcgQEAgc3RhdGljIHN0cnVjdCBjb21iaW5lX2RpZmZfcGF0aCAqaW50ZXJz
ZWN0X3BhdGhzKAogCQkJLyogcC0+cGF0aCBub3QgaW4gcS0+cXVldWVbXTsgZHJvcCBpdCAqLwog
CQkJKnRhaWwgPSBwLT5uZXh0OwogCQkJZm9yIChqID0gMDsgaiA8IG51bV9wYXJlbnQ7IGorKykK
LQkJCQlpZiAoY29tYmluZWRfYWxsX3BhdGhzICYmCi0JCQkJICAgIGZpbGVuYW1lX2NoYW5nZWQo
cC0+cGFyZW50W2pdLnN0YXR1cykpCi0JCQkJCXN0cmJ1Zl9yZWxlYXNlKCZwLT5wYXJlbnRbal0u
cGF0aCk7CisJCQkJZnJlZShwLT5wYXJlbnRbal0uY2hhbmdlZF9wYXRoKTsKIAkJCWZyZWUocCk7
CiAJCQljb250aW51ZTsKIAkJfQpAQCAtMTA4LDEwICsxMDIsOSBAQCBzdGF0aWMgc3RydWN0IGNv
bWJpbmVfZGlmZl9wYXRoICppbnRlcnNlY3RfcGF0aHMoCiAJCW9pZGNweSgmcC0+cGFyZW50W25d
Lm9pZCwgJnEtPnF1ZXVlW2ldLT5vbmUtPm9pZCk7CiAJCXAtPnBhcmVudFtuXS5tb2RlID0gcS0+
cXVldWVbaV0tPm9uZS0+bW9kZTsKIAkJcC0+cGFyZW50W25dLnN0YXR1cyA9IHEtPnF1ZXVlW2ld
LT5zdGF0dXM7Ci0JCWlmIChjb21iaW5lZF9hbGxfcGF0aHMgJiYKLQkJICAgIGZpbGVuYW1lX2No
YW5nZWQocC0+cGFyZW50W25dLnN0YXR1cykpCi0JCQlzdHJidWZfYWRkc3RyKCZwLT5wYXJlbnRb
bl0ucGF0aCwKLQkJCQkgICAgICBxLT5xdWV1ZVtpXS0+b25lLT5wYXRoKTsKKwkJcC0+cGFyZW50
W25dLmNoYW5nZWRfcGF0aCA9IGNvbWJpbmVkX2FsbF9wYXRocyAmJgorCQkJCSAgICBmaWxlbmFt
ZV9jaGFuZ2VkKHAtPnBhcmVudFtuXS5zdGF0dXMpID8KKwkJCQkgICAgeHN0cmR1cChxLT5xdWV1
ZVtpXS0+b25lLT5wYXRoKSA6IE5VTEw7CiAKIAkJdGFpbCA9ICZwLT5uZXh0OwogCQlpKys7CkBA
IC05OTYsOCArOTg5LDkgQEAgc3RhdGljIHZvaWQgc2hvd19jb21iaW5lZF9oZWFkZXIoc3RydWN0
IGNvbWJpbmVfZGlmZl9wYXRoICplbGVtLAogCiAJaWYgKHJldi0+Y29tYmluZWRfYWxsX3BhdGhz
KSB7CiAJCWZvciAoaSA9IDA7IGkgPCBudW1fcGFyZW50OyBpKyspIHsKLQkJCWNoYXIgKnBhdGgg
PSBmaWxlbmFtZV9jaGFuZ2VkKGVsZW0tPnBhcmVudFtpXS5zdGF0dXMpCi0JCQkJPyBlbGVtLT5w
YXJlbnRbaV0ucGF0aC5idWYgOiBlbGVtLT5wYXRoOworCQkJY29uc3QgY2hhciAqcGF0aCA9IGVs
ZW0tPnBhcmVudFtpXS5jaGFuZ2VkX3BhdGggPworCQkJCQkgICBlbGVtLT5wYXJlbnRbaV0uY2hh
bmdlZF9wYXRoIDoKKwkJCQkJICAgZWxlbS0+cGF0aDsKIAkJCWlmIChlbGVtLT5wYXJlbnRbaV0u
c3RhdHVzID09IERJRkZfU1RBVFVTX0FEREVEKQogCQkJCWR1bXBfcXVvdGVkX3BhdGgoIi0tLSAi
LCAiIiwgIi9kZXYvbnVsbCIsCiAJCQkJCQkgbGluZV9wcmVmaXgsIGNfbWV0YSwgY19yZXNldCk7
CkBAIC0xMjc4LDEyICsxMjcyLDEwIEBAIHN0YXRpYyB2b2lkIHNob3dfcmF3X2RpZmYoc3RydWN0
IGNvbWJpbmVfZGlmZl9wYXRoICpwLCBpbnQgbnVtX3BhcmVudCwgc3RydWN0IHJlCiAKIAlmb3Ig
KGkgPSAwOyBpIDwgbnVtX3BhcmVudDsgaSsrKQogCQlpZiAocmV2LT5jb21iaW5lZF9hbGxfcGF0
aHMpIHsKLQkJCWlmIChmaWxlbmFtZV9jaGFuZ2VkKHAtPnBhcmVudFtpXS5zdGF0dXMpKQotCQkJ
CXdyaXRlX25hbWVfcXVvdGVkKHAtPnBhcmVudFtpXS5wYXRoLmJ1Ziwgc3Rkb3V0LAotCQkJCQkJ
ICBpbnRlcl9uYW1lX3Rlcm1pbmF0aW9uKTsKLQkJCWVsc2UKLQkJCQl3cml0ZV9uYW1lX3F1b3Rl
ZChwLT5wYXRoLCBzdGRvdXQsCi0JCQkJCQkgIGludGVyX25hbWVfdGVybWluYXRpb24pOworCQkJ
Y29uc3QgY2hhciAqcGF0aCA9IHAtPnBhcmVudFtpXS5jaGFuZ2VkX3BhdGggPworCQkJCQkgICBw
LT5wYXJlbnRbaV0uY2hhbmdlZF9wYXRoIDoKKwkJCQkJICAgcC0+cGF0aDsKKwkJCXdyaXRlX25h
bWVfcXVvdGVkKHBhdGgsIHN0ZG91dCwgaW50ZXJfbmFtZV90ZXJtaW5hdGlvbik7CiAJCX0KIAl3
cml0ZV9uYW1lX3F1b3RlZChwLT5wYXRoLCBzdGRvdXQsIGxpbmVfdGVybWluYXRpb24pOwogfQpA
QCAtMTY0NSw5ICsxNjM3LDcgQEAgdm9pZCBkaWZmX3RyZWVfY29tYmluZWQoY29uc3Qgc3RydWN0
IG9iamVjdF9pZCAqb2lkLAogCQlzdHJ1Y3QgY29tYmluZV9kaWZmX3BhdGggKnRtcCA9IHBhdGhz
OwogCQlwYXRocyA9IHBhdGhzLT5uZXh0OwogCQlmb3IgKGkgPSAwOyBpIDwgbnVtX3BhcmVudDsg
aSsrKQotCQkJaWYgKHJldi0+Y29tYmluZWRfYWxsX3BhdGhzICYmCi0JCQkgICAgZmlsZW5hbWVf
Y2hhbmdlZCh0bXAtPnBhcmVudFtpXS5zdGF0dXMpKQotCQkJCXN0cmJ1Zl9yZWxlYXNlKCZ0bXAt
PnBhcmVudFtpXS5wYXRoKTsKKwkJCWZyZWUodG1wLT5wYXJlbnRbaV0uY2hhbmdlZF9wYXRoKTsK
IAkJZnJlZSh0bXApOwogCX0KIApkaWZmIC0tZ2l0IGEvZGlmZi1saWIuYyBiL2RpZmYtbGliLmMK
aW5kZXggYzZkM2JjNGQzNy4uNjAyYWUwYzg0YiAxMDA2NDQKLS0tIGEvZGlmZi1saWIuYworKysg
Yi9kaWZmLWxpYi5jCkBAIC00MTcsOSArNDE3LDExIEBAIHN0YXRpYyBpbnQgc2hvd19tb2RpZmll
ZChzdHJ1Y3QgcmV2X2luZm8gKnJldnMsCiAJCW1lbXNldChwLT5wYXJlbnQsIDAsIDIgKiBzaXpl
b2Yoc3RydWN0IGNvbWJpbmVfZGlmZl9wYXJlbnQpKTsKIAkJcC0+cGFyZW50WzBdLnN0YXR1cyA9
IERJRkZfU1RBVFVTX01PRElGSUVEOwogCQlwLT5wYXJlbnRbMF0ubW9kZSA9IG5ld19lbnRyeS0+
Y2VfbW9kZTsKKwkJcC0+cGFyZW50WzBdLmNoYW5nZWRfcGF0aCA9IE5VTEw7CiAJCW9pZGNweSgm
cC0+cGFyZW50WzBdLm9pZCwgJm5ld19lbnRyeS0+b2lkKTsKIAkJcC0+cGFyZW50WzFdLnN0YXR1
cyA9IERJRkZfU1RBVFVTX01PRElGSUVEOwogCQlwLT5wYXJlbnRbMV0ubW9kZSA9IG9sZF9lbnRy
eS0+Y2VfbW9kZTsKKwkJcC0+cGFyZW50WzFdLmNoYW5nZWRfcGF0aCA9IE5VTEw7CiAJCW9pZGNw
eSgmcC0+cGFyZW50WzFdLm9pZCwgJm9sZF9lbnRyeS0+b2lkKTsKIAkJc2hvd19jb21iaW5lZF9k
aWZmKHAsIDIsIHJldnMpOwogCQlmcmVlKHApOwpkaWZmIC0tZ2l0IGEvZGlmZi5oIGIvZGlmZi5o
CmluZGV4IDZlNjAwN2MxN2IuLmQxM2JlMTQyZGQgMTAwNjQ0Ci0tLSBhL2RpZmYuaAorKysgYi9k
aWZmLmgKQEAgLTQ4MCw3ICs0ODAsNyBAQCBzdHJ1Y3QgY29tYmluZV9kaWZmX3BhdGggewogCQlj
aGFyIHN0YXR1czsKIAkJdW5zaWduZWQgaW50IG1vZGU7CiAJCXN0cnVjdCBvYmplY3RfaWQgb2lk
OwotCQlzdHJ1Y3Qgc3RyYnVmIHBhdGg7CisJCWNoYXIgKmNoYW5nZWRfcGF0aDsgLy8gTlVMTCB1
bmxlc3Mgc3RhdHVzID09ICdSJyBvciAnQycsIHNlZSBmaWxlbmFtZV9jaGFuZ2VkKCkKIAl9IHBh
cmVudFtGTEVYX0FSUkFZXTsKIH07CiAjZGVmaW5lIGNvbWJpbmVfZGlmZl9wYXRoX3NpemUobiwg
bCkgXApkaWZmIC0tZ2l0IGEvdHJlZS1kaWZmLmMgYi90cmVlLWRpZmYuYwppbmRleCBkOTIzN2Zm
ZDliLi44NWYxZDJhNGE2IDEwMDY0NAotLS0gYS90cmVlLWRpZmYuYworKysgYi90cmVlLWRpZmYu
YwpAQCAtMjcyLDYgKzI3Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgY29tYmluZV9kaWZmX3BhdGggKmVt
aXRfcGF0aChzdHJ1Y3QgY29tYmluZV9kaWZmX3BhdGggKnAsCiAJCQl9CiAKIAkJCXAtPnBhcmVu
dFtpXS5tb2RlID0gbW9kZV9pOworCQkJcC0+cGFyZW50W2ldLmNoYW5nZWRfcGF0aCA9IE5VTEw7
CiAJCQlvaWRjcHkoJnAtPnBhcmVudFtpXS5vaWQsIG9pZF9pKTsKIAkJfQogCg==
--000000000000627409062afcd2f0--
