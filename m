Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205F23767
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706466773; cv=none; b=GUfzz0+tGIDFNiMop6kaFJh8fU8pdHruI1ynvatT/JvNI6e0Y6tKsOzeF688lBccwNSHyGSA7UGoiiNIfXiv1t0inY1Xu7XYhh+iSUGu/vCOaDitQcX3lAsKY1Mzw63CdsrpUTf5wrUrYYfWTmnvYJDZ1sPuyjuL9MwaGHNHuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706466773; c=relaxed/simple;
	bh=1sWsrooQ8Xu0bQm5NafgZmUOkmWPBPltN4iOZZaYO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Idc9QwEpmYVwxH/h6+FoiqMIqlr7335Kl9PIU6ci3fHfo1Lmx3vJZ6V2uK2aw+NNy3Jj7CxU58Vz1pqjJ0Boe+z6FIH5lb5FYb/Vg7bPLKUMF44SlaePMVtpcBbS12v9MCznA/mo48yRihCAWUBxvk0UKTYztPXKuTxxtKg0nqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=IBE9CWoP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bU0wbbe5; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="IBE9CWoP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bU0wbbe5"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id D47C63200ADC;
	Sun, 28 Jan 2024 13:32:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 28 Jan 2024 13:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm2; t=1706466769; x=
	1706553169; bh=L7sDlXn0j72ARKaWZd+TpjVKBfmGWKqFbc6PqwUPwn0=; b=I
	BE9CWoP8QFkb7FPSKf7CeIfogHJVw35EB5/ioyodT0G9g0p6ipggyX2jpD+ofRGU
	1WDvqjYC7AolMRSyR2utdHRMsi4XSwTMUXcWC4p0Iaxa8fpNe+C89ch3GprS3uAG
	24tZkLM99e+5RnsRdO8k9KtQe/L38SPISHMUgRw4y3y0OkaW2AE43A2ZeEDL05J6
	4ch0u1QvHuPHlerkVSzRA357X1pfiPBHDt2qByt93j5CKiuQZHviClHPD6NP3Rgb
	bdyVbMQkrB4fGwIsDyI7IzVoCJl2P9kZte1vgO5jaIN0YxwrQ2hyZP/eN4/t7foZ
	oCWHH7H8y7N9ODbhqoHyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706466769; x=1706553169; bh=L7sDlXn0j72AR
	KaWZd+TpjVKBfmGWKqFbc6PqwUPwn0=; b=bU0wbbe5DfHyzqIIy6RxPT06sCThL
	4qXg1JYTEGKI3R0DXuZA+twI2J9puz/uuOqg1CZzSK+QSkt1rR+412XXEzO+RlDZ
	gV31MfhCXo/qMuOapehIQWv7P5WtSrhkVFhNjjiQmuQXxjJEizUbiatKH4GAfLxm
	6LzMlXwBnt1TTan+woSJkXlQYT6KqQmtKuH6HG021hXSQ5QGqjIdgPuDVLDF84LG
	DMfTTRMDk15AnkgW4Qg1fgWkgOYJeZBI7R7y3cEQJj/4oK+ceYcD2lDCCEG6EyX+
	+w3d2EdRKuMyyn797/LtI/fMWJvPmfZkqpHKQXurE6vCzy8/gsaMoKR8g==
X-ME-Sender: <xms:0Z22ZZ1OCtUjrGBhGml9tXvzUXQeYO2CmOAHCLe_AiINuCBtL3E53iw>
    <xme:0Z22ZQGjtt7MmOWBzvzEAhXSniQN_iXpEYS0rCEnqVGkRlxLngp7UlaHL9AG8kNA_
    qDPDlWeAmJLaTRRug>
X-ME-Received: <xmr:0Z22ZZ6lggQx4xRrtEMHQVp1z6MRvQ9nRCB_PF5BzUbZYyaEdIvsVF0ywJnncttev_17GmlIyvyYDtPcQKQVxFsDaWq4n_lobadHgc_VEyk-zJ-0yAletctKqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtke
    ertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteegtd
    egheeiheefjedtlefhueeuieettdetgfethfevveeutdelvdefjeehveejnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:0Z22ZW3k90LMnI_IKXBiSH8MltNO4u5uidO5MjmyV4q45-WWehZlXA>
    <xmx:0Z22ZcH0hZHR_wLzY9zr65ZS5Ajbv5lWs556TBr6ePbXmPMk9Yyuog>
    <xmx:0Z22ZX84wdAFb7dfELW1BlBMdpBSbBjxvG4o_tcPtBB2oYv3clDI1Q>
    <xmx:0Z22ZWMw7GpGAW-xoUvsMlp-fJCndTR20Jw5H1_noaEk9vVWmyzLLw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 13:32:47 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im
Subject: [PATCH 0/1] config: add back code comment
Date: Sun, 28 Jan 2024 19:31:39 +0100
Message-ID: <cover.1706466321.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a follow-up to the kh/maintenance-use-xdg-when-it-should
[series] which was merged in 12ee4ed506 (Merge branch
'kh/maintenance-use-xdg-when-it-sho.., 2024-01-26).

I dropped a code comment while iterating on a refactor. It still makes
as much sense in this context as before the refactor (it’s a _refactor_
in the sense of “don’t change code behavior”).

The code comment was moved to `config.c` in patch v1 3/4.[1] But review
feedback said that this comment didn’t fit in this new place and that we
shouldn’t `die()` in `git_global_config`. So in v2 3/4[2] I removed the
comment in `git_global_config`. But I forgot to put the comment back to
its original place, where it still makes as much sense as before my
series.

[Here] is the diff when I squash this patch into c15129b699 (config:
factor out global config file retrieval, 2024-01-18).

Sorry about the churn.

Cc: ps@pks.im

🔗 series: https://lore.kernel.org/git/cover.1697660181.git.code@khaugsbakk.name/
🔗 1: https://lore.kernel.org/git/147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name/
🔗 2: https://lore.kernel.org/git/32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name/
† Here:

    diff --git a/builtin/config.c b/builtin/config.c
    index 6fff265581..b55bfae7d6 100644
    --- a/builtin/config.c
    +++ b/builtin/config.c
    @@ -708,10 +708,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
            }

            if (use_global_config) {
    -		char *user_config, *xdg_config;
    -
    -		git_global_config_paths(&user_config, &xdg_config);
    -		if (!user_config)
    +		given_config_source.file = git_global_config();
    +		if (!given_config_source.file)
                            /*
                             * It is unknown if HOME/.gitconfig exists, so
                             * we do not know if we should write to XDG
    @@ -719,19 +717,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
                             * is set and points at a sane location.
                             */
                            die(_("$HOME not set"));
    -
                    given_config_source.scope = CONFIG_SCOPE_GLOBAL;
    -
    -		if (access_or_warn(user_config, R_OK, 0) &&
    -		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
    -			given_config_source.file = xdg_config;
    -			free(user_config);
    -		} else {
    -			given_config_source.file = user_config;
    -			free(xdg_config);
    -		}
    -	}
    -	else if (use_system_config) {
    +	} else if (use_system_config) {
                    given_config_source.file = git_system_config();
                    given_config_source.scope = CONFIG_SCOPE_SYSTEM;
            } else if (use_local_config) {
    diff --git a/config.c b/config.c
    index ebc6a57e1c..3cfeb3d8bd 100644
    --- a/config.c
    +++ b/config.c
    @@ -1987,6 +1987,26 @@ char *git_system_config(void)
            return system_config;
     }

    +char *git_global_config(void)
    +{
    +	char *user_config, *xdg_config;
    +
    +	git_global_config_paths(&user_config, &xdg_config);
    +	if (!user_config) {
    +		free(xdg_config);
    +		return NULL;
    +	}
    +
    +	if (access_or_warn(user_config, R_OK, 0) && xdg_config &&
    +	    !access_or_warn(xdg_config, R_OK, 0)) {
    +		free(user_config);
    +		return xdg_config;
    +	} else {
    +		free(xdg_config);
    +		return user_config;
    +	}
    +}
    +
     void git_global_config_paths(char **user_out, char **xdg_out)
     {
            char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
    diff --git a/config.h b/config.h
    index e5e523553c..5dba984f77 100644
    --- a/config.h
    +++ b/config.h
    @@ -382,6 +382,7 @@ int config_error_nonbool(const char *);
     #endif

     char *git_system_config(void);
    +char *git_global_config(void);
     void git_global_config_paths(char **user, char **xdg);

     int git_config_parse_parameter(const char *, config_fn_t fn, void *data);


Kristoffer Haugsbakk (1):
  config: add back code comment

 builtin/config.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0

