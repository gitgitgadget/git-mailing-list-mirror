Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5C42902D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275974; cv=none; b=A4TT1HxNmYxTYJkiB3lW6uhM16/QyM5ieB3rIMwuI7xzavRNakoueFCSCND5wdj9+YyInaxwR72lsz/nT0Jbofilsjr3hKV23dG3L32d7faNqyc15bQtREpktDLprzCF4gjUig9V/JmEv4gdByaVGV+bIehOkpFedCgvvWAvsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275974; c=relaxed/simple;
	bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyIVJoY3wjZMA2G3RZGpsIZKM5Kk4ljy3k8h/ncf3hjJouvEuh+tje7RqzSwsKSEInHuqjjrYrueyGxfWcluutwFO9O7NmKLxcFrcrvBSpuzMr0flb+BqFJd3a7fk6+D5rQQ1Ufj8NDgxJD02Zp8d87FPHmxH5vig7+07W+q3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEzR6Hc8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEzR6Hc8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8f86c6deso29253305e9.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275971; x=1788880771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=FEzR6Hc8KNXAVakBMefYRCkkKf3kZf1A7NpLTTIoPu0qe7MlY5iEFhlx0/im2C6dDE
         eZyTigF+MRWobZJ7oB0xJpVlW8YhsOBnUEnnQKcqdVnB/7WDPxV9rE393voZhBXB3nTh
         luxPyOd7dwH1hNPKaqs+TmmYEspwyObMiNtuwurABTEuArTImBzSILBRLOaj2LQrOeQw
         MzhLR31HiPIXwynshAITwT1fh3bMvX/4uF4EJwbgSa9jloeGDCmkOAvcD6I5I2K2N2KY
         aXoAOhZwsLkNuV1Daq5j4afuh2rvV0I5WLOWIWJX8BEoZVWs+5Thp2enqQ9wjomDCRkW
         kpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275971; x=1788880771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=Cj7i/S6Cu+1S1gm44KRt4o5XewGlt+lXpTV3GlNDgINIpb81P2seKONm4JKqOdCU+m
         gUwjzsyJrDVcL655dYlWb8m3SLcovQ2NFu9Wl468pQggEdyh6shUGfzWOFjmZN/I40Kq
         eHK1iBBkMfi4HudWoG4c0j0p74S/FyyjnUML12oIxh1fhkqFoHs6SfMVBI7wqvjr2uo9
         9Ry+pSlXbnzZYCq/sX+TfDzO/+riy8DyRJgXO4FDzVyc2oEHOi1ouDYbW5JmX0pLy0un
         /M5gL4UxgEm154WfmW88b0Es3vZvID1y9o3CSASZxlFcmRjDTbej0OhZ4iHIEWXDgtg8
         VFWg==
X-Gm-Message-State: AFuF++kB9UxixkbHpSmrG5PmvLqSZ3cKAsd2600cXGgDYPzOGpEmPqpI
	RQR74OCIR0AvEFmKEu2PaLOahINEZL8d3AEeGUhrGgy3GYNh0kLBbhV4
X-Gm-Gg: AR+sD12R1trO3zubQHdXRDDGHv9OumC5E356Dkt16mWah1a/lqQxmPm8vwc9zqwc0pp
	1qtYwPIRMDqaFGDPJ1osYe0TE2b5P3fFoMSqmm5gQRFXBGQEZNFXjYA3H7Cgt32Sby2QupiksdC
	s5hPe6mmtAzbJFyZHUogC2TcF92jyEJjYtdrhlRTybhD5Twj5ZNXFaeoMsBPQA9hxlqjNX3dIS7
	CBmMeNoCfmhsHStS9Nr+QSTN/DgYmw3WYhgyTaesQXLgY1zLrYXxCdFA8lSDjypptvpEsP8ToV6
	5yIrf4zLeaFkLsA8eXlTXAHmXZ7D211HwBb/4BIR1mWFRj3YIQUQnrY0ULJu1KcHJ5VEVGmw3S6
	wTvv+CeaaHaKY4er+GVx1jPaF05wHOwVF2p9vxUAORL6rleCohhtEPVy1t4OToxv21J1c5ayQhH
	nOZHxkQWp6pvIJLG1kT96ehr7e9iPZ7EA8mCaNgHvqNm6/NoOqcdgsNLXST1CAZ4xKJWY0ku+k8
	BBxVCROpVmMaU1jZgt2aBqvC0g=
X-Received: by 2002:a05:600c:858e:b0:49c:d331:98bf with SMTP id 5b1f17b1804b1-49cd331993dmr274345975e9.8.1788275970623;
        Tue, 01 Sep 2026 08:19:30 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:645f:6387:edab:db53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm17270605e9.13.2026.09.01.08.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:19:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Sep 2026 17:19:23 +0200
Subject: [PATCH v5 1/3] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-758-introduce-hook-v5-1-35cdc6be3cc1@gmail.com>
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
In-Reply-To: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqW7P+d7VucbRaOTa0xNMLU/Lw1pVq9hLa0b
 kSuxOO3thcScYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqluz/AAoJED7VnySO
 Rox/JwYL/2wnrCcgiicbw6/33UWVyAzh9/GsLWD+IYtuKYmhYct+f/hfs16OKAkqm4fUDVY6qgz
 N8ymeVMQC1oHbtsPohU0vLi2xbdQpzI2kdSWf1wqk4ctromkmej8WXCtNteuRq5KnYEBDU6qGuh
 qX2+Z72T9hQT3GtKBYAs6AYZx44TKn7jFCkJlsyrq1OvyelFHX/Z+hUYIjUfcbhVicQSXfzXBzm
 7jv38kRACrzUtky/Oe4HM6KaENH8/xQPJZrezza+NdLHtEOgLuB4XnuRGY41slDzJoO2IWPp03g
 UfuG7IPc5w+1pOEkcUOQcWWv2wh5IhIgr1uqegTfyscSjf9eNG+Bwzi6MqIZdw+ykw8MRo0xjp1
 ZnMIoCjYcDgBqTkZS+JJ44hdHxWa2nn2bdWGyUzhK/gZIa1yjygMQFe+9yyWdOv4JSOrJgX/WWU
 Hz/Pmlkz0Cuz+dfOwppRQ0PUauboJayLtNvd0EOr28eYM+qiNao1mUYpdRNSEJ5LgZprv3N1dl6
 0E=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The manpage of git-receive-pack(1) documents hooks invoked when
receiving a push. The manpage does not mention the 'proc-receive' hook
though, which is also invoked as part of that process. Add a paragraph
about this hook to plug that gap.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..5806792ba7 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,14 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

