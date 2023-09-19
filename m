Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BC0CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 19:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjISTpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISTpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 15:45:54 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44CE9C
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 12:45:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BE9C53200943;
        Tue, 19 Sep 2023 15:45:47 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 19 Sep 2023 15:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695152747; x=
        1695239147; bh=kFvO0Cyz5JiM/S1mzdtigSs8Gq9gKX1A0+UmO+sMIU8=; b=P
        Zpd0qGJN0WqKVmY2RPAIATO1T5qSfOQTu+FWWFyJ1dxP/ECyu7VM7OocuSgwZgkp
        /2ES4SyKr4Iqozg+GrKmThU+6TekhI/b6c+Oi/DyQp3wmfeerKabh07gzDZU6Iyt
        S7OLMFzqH9FbX7LpU+aYEnNi/X5OkJI+p815kv+HRT5HrBYjScx38fdgoVzZAHUT
        KRtj6CfLwBbY6GESt7tPag5yM38CmSuczGIDdt+jPMDR53bTrDFoyjQD8i0JoocL
        rDLB/rBINRzSPKSdMYUIuP75/AjndmlSSqYJYo2qwipZF6o8MCpRKs6RUNx3l/4y
        vaX0pBrV6VAjVPCB0axtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695152747; x=1695239147; bh=kFvO0Cyz5JiM/
        S1mzdtigSs8Gq9gKX1A0+UmO+sMIU8=; b=bSF7tZ+bQWhYrNolP1o+hFo0nOgd5
        xun4StR+QzP2SiR59o3bF8hYcwXyOm12/rKdUeudutl21YAdq98QhDoGP8s7F1oM
        n0z476pkV3PYw3DCgoi83mgqA0ZnVG4YQL9t+PrddMDv2FxGOvJ9gqTYNkni/dm8
        y8M7ysS1pEjm/7xlAg63OF//ZAdN5dIThw1JMIv/zMGpPuZeuAuS4GOTqM1Tb7y0
        AJZHqnkifsHSyf5DeaOT2uw221QZjq75isq69tTBAvHKn3zPNrY8M6fC70rsh8Zd
        gDsBgqjfwmXbGYgNKXLO8uwu6N2zJC8JXE+wkH+jAAxBTTLTmV7yDw7OA==
X-ME-Sender: <xms:a_oJZXW6M7vN89fTIWEq6Vyi3ZsSeaPRHG_9t2XniheXBAcKuV2fCGk>
    <xme:a_oJZfmdXdDkXdu2pSTTiYsxZCm56F6qn_eRCaIQT8glzPlo5KIcdDnMOgP5PBvrX
    3MuS5Mn1qKeknQWeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:a_oJZTZRtlocY4lB_fgAwraWnB_uB484U_kF6hsUy9vInrMAAKyiXQ>
    <xmx:a_oJZSWEQmPCOZqslGBVo_C1Vx_7tvegAxhsyBEFK55CzC7y6VwlXQ>
    <xmx:a_oJZRlGayqqpKazTECkrEngzYMtZuf-0PIRYGeTWV-Xp8D9OBTU-A>
    <xmx:a_oJZWydxX1KOVfgc_zP8LPWHWsvxrGNZT2Cf2Ri8L7EEUdwl4KvWw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0C7B715A0091; Tue, 19 Sep 2023 15:45:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <6ad470bd-207f-4735-9ab5-2da5010d9ef4@app.fastmail.com>
In-Reply-To: <xmqqled2ezfh.fsf@gitster.g>
References: <cover.1694383247.git.code@khaugsbakk.name>
 <cover.1695144790.git.code@khaugsbakk.name>
 <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
 <xmqqled2ezfh.fsf@gitster.g>
Date:   Tue, 19 Sep 2023 21:44:20 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Denton Liu" <liu.denton@gmail.com>, "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v4 1/1] range-diff: treat notes like `log`
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2023, at 21:27, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
>> [snip]
>
> Very well described.  I think the rest of the proposed log message
> is redundant now we have quite a good write-up above.

Thanks!

>
>>  ifndef::git-rev-list[]
>> +--show-notes-by-default::
>> +	Show the default notes (see `--notes`) unless subsequent arguments
>> +	are used to display specific notes.
>> +
>>  --notes[=<ref>]::
>>  	Show the notes (see linkgit:git-notes[1]) that annotate the
>>  	commit, when showing the commit log message.  This is the default
>
> I think the new entry should come after the description of `--notes`,
> which is the primary option around the "notes" feature.
>
> In the description, I think "subsequent" is misphrased.  It makes it
> sound as if
>
>     $ git log --show-notes-by-default --notes=amlog
>
> would stop showing the notes from the default notes tree (because
> the notes from the .git/refs/notes/amlog is explicitly asked for),
> while
>
>     $ git log --notes=amlog --show-notes-by-default
>
> would show both the default and the custom notes, which is not what
> the code does, I think, in this hunk:
>
>> @@ -3054,6 +3056,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>  	if (revs->expand_tabs_in_log < 0)
>>  		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
>>
>> +	if (!revs->show_notes_given && revs->show_notes_by_default) {
>> +		enable_default_display_notes(&revs->notes_opt, &revs->show_notes);
>> +		revs->show_notes_given = 1;
>> +	}
>> +
>>  	return left;
>>  }
>
> Other than the above minor nits, looks very good.
>
> Thanks.

Okay I think I understand. With that in mind I would change it to the
patch below.

I can make a new version if that looks okay.

-- >8 --
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index dcd501ee505..d2df1aad647 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -59,10 +59,6 @@ message by 4 spaces (i.e.  'medium', which is the default, 'full',
 and 'fuller').
 
 ifndef::git-rev-list[]
---show-notes-by-default::
-	Show the default notes (see `--notes`) unless subsequent arguments
-	are used to display specific notes.
-
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
@@ -91,6 +87,10 @@ being displayed. Examples: "--notes=foo" will show only notes from
 	"--notes --notes=foo --no-notes --notes=bar" will only show notes
 	from "refs/notes/bar".
 
+--show-notes-by-default::
+	Show the default notes unless arguments are given for displaying
+	specific notes.
+
 --show-notes[=<ref>]::
 --[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
