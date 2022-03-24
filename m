Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC247C43217
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 12:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350100AbiCXMXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242877AbiCXMXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 08:23:05 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB66A5EB2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 05:21:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E1290320187F;
        Thu, 24 Mar 2022 08:21:28 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Thu, 24 Mar 2022 08:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=WEzwOvaLVkJkYiHecqMwx9ADtrnllRagLcSZGB
        qa6Oo=; b=V9vH74A2FqODyYuPH57Uk8UnL17RqaKP/TF+lxTuPfObd0mLbo3xWs
        ghD/6zLbvmQxBLyaafkRZuAdG5s47kqlGoQCxm1wNDI/LYnvFpdaf6/qgEg1Fj8k
        G5Q6c8Und7psv8m79igBPg0z/QCVCUla630AuY6+cDexftrDWKTxtIhlQA5TWPBu
        ELHTAjFHIIcaEdHeGSUXUDYYZINIRTcgDIHWtfCP5297l6MOVfQo2ZIGKR7CJ3c2
        PZ1lzeZoMqoEkx9R1NJLfrLA66Wt3W8mULxOaEtPjeSkviCTJHBERxBsyphTpZDD
        KBCwf7OU4nVqRxjEvId9423LbP6RNuWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WEzwOvaLVkJkYiHec
        qMwx9ADtrnllRagLcSZGBqa6Oo=; b=OidzAWkXjiOdhU9X5eNgxBi4bnKVSAA+6
        hs1j6E6jFof7qbWCvZv4bW4SWpUszuU2nTZFPj++JZdYAbHFw6y60+h0C6A2r6SA
        P7Qe/jSEm3svUdXasIPktWtgaYDjzn1wQyWRMedS4CKi7kMl3ImSmabT4dVpzKSp
        xylAD7QaWnAPhySt07UOJBz95jH6Jq/6w32O2YiwHJjgz09O9IMqfLRS8tXI+OQd
        NuHSs+018b+kdsxv78WxyUvcBPxQfptnyrTNA43IuKyRN3+eRx1HeTm3tXd1ryjt
        7bPUuyq7agabMRo8jxlroEP8smhvBfBBavYf4XJoBTge8MeJWGBMQ==
X-ME-Sender: <xms:R2I8YhUligr9oz29eeKbkp7XUTH7xEkz6sCPxCZsAzgblfEMLLADAQ>
    <xme:R2I8YhnEdEfXT4wMd_O-eLtbIV9IDhDtqBQtpHtByM4AFa5ok6z2uv2RkVeGdZjJ1
    YJnxSaV-WAgs3p3cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpefhvghrnhgrnhguohcuoehgrhgvvghnfhhoohesuhelvddr
    vghuqeenucggtffrrghtthgvrhhnpeetgeffleffleetuddthfffgeefieetgfdvvdevff
    evieelveeiteelheegleeugfenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvg
    hnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:R2I8YtZMUsFNl3UKqZZOgtG5eFUyEU96a3q0otobJYoeWZoL8Ho7GA>
    <xmx:R2I8YkVnPu9F12Q-L15UD9kChOy0yLr0tKstPuAlomXQrF9C-V21FQ>
    <xmx:R2I8Yrm6OTRFr2TGhSvzo72BFsoNZV4EHF5NrIUL2sTS6cP3OXke9g>
    <xmx:SGI8YkAEAVbUlT_ZjrXPurTsc2HLAAcJ7b9ofNY-551P114m9WZPXg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC85424A0074; Thu, 24 Mar 2022 08:21:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4911-g925b585eab-fm-20220323.003-g925b585e
Mime-Version: 1.0
Message-Id: <29c787c2-8916-4d04-85c1-a4c0597b9848@www.fastmail.com>
In-Reply-To: <xmqqsfr8sjpl.fsf@gitster.g>
References: <20220319091141.4911-1-greenfoo@u92.eu>
 <20220319091141.4911-2-greenfoo@u92.eu> <xmqqsfr8sjpl.fsf@gitster.g>
Date:   Thu, 24 Mar 2022 13:21:05 +0100
From:   Fernando <greenfoo@u92.eu>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v5 1/3] vimdiff: new implementation with layout support
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +debug_print() { 
> > +	# Send message to stderr if global variable DEBUG is set to "true"
> > +
> > +	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
> > +	then
> > +		>&2 echo "$@"
> > +	fi
> > +}
> 
> Do we want to keep this helper, and many calls to it sprinkled in
> this file, or are they leftover cruft?

I left it in case we ever need to debug this script in the future. But if you
think it's not worth it, I can delete it. We have three options:

  A) Leave it
  B) Completely remove it
  C) Remove the function and replace the places where it is being called by
     a commented out "echo" to stderr

Let me know what you prefer.


> Style.  "debug_print () {", i.e. SPACE on both sides of "()".

Sure. No problem. I'll fix all function declarations (they are all missing the
extra space before the opening parenthesis)


> > +substring() {
> > +	# Return a substring of $1 containing $3 characters starting at
> > +	# zero-based offset $2.
> > +	# 
> > +	# Examples:
> > +	#
> > +	#   substring "Hello world" 0 4  --> "Hell"
> > +	#   substring "Hello world" 3 4  --> "lo w"
> > +	#   substring "Hello world" 3 10 --> "lo world"
> > +
> > +	STRING=$1
> > +	START=$2
> > +	LEN=$3
> > +
> > +	echo "$STRING" | cut -c$(( START + 1 ))-$(( START + $LEN))
> > +}
> 
> The lack of space before the second closing "))" makes it look
> inconsistent. 

No problem. I'll fix it.


> We should be able to do this no external commands
> and just two variable substitutions and without relying on
> bash-isms, but the above should do.
> 

In v1 of this patch series, instead of this function, I was doing this other
thing:

    X=${Y:a:b}

...but that is a bash-ism, so I replaced it with what you see above ("echo" +
"cut")

I was not able to find another way of doing it using just standard POSIX shell
syntax [1] (notice that "cut" is included in IEEE Std 1003.1 [2] so it shouldn't
be an issue to rely on it)

In any case, if anyone knows how we could achieve the same without using
external commands, please let me know and I'll change it (in the meantime I'll
keep searching for alternatives too). If after a reasonable amount of time none
of us manages to find a solution I suggest to leave it as it is now.

[1] https://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html
[2] https://pubs.opengroup.org/onlinepubs/009696699/utilities/cut.html


> > +	if $base_present
> > +	then
> > +		eval "$merge_tool_path" \
> > +			-f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> > +	else
> > +		# If there is no BASE (example: a merge conflict in a new file
> > +		# with the same name created in both braches which didn't exist
> > +		# before), close all BASE windows using vim's "quit" command
> > +
> > +		FINAL_CMD=$(echo "$FINAL_CMD" | \
> > +			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')
> > +
> > +		eval "$merge_tool_path" \
> > +			-f "$FINAL_CMD" "$LOCAL" "$REMOTE" "$MERGED"
> > +	fi
> 
> 
> I wonder if there were an easy way to "compare" the $FINAL_CMD this
> new code feeds to $merge_tool_path and what was fed to it by the
> original code to show that we are not regressing what the end user
> sees.
> 
> The "run_unit_tests()" only compares the cmd generated for each
> given layout, but the original vimdiff$N didn't express them in
> terms of $layout this patch introduces, so unfortunately that is not
> it.
> 
> Ideas?

Before this patch series, this is what each variant fed into "$merge_tool_path":

  - vimdiff:
      -f -d -c '4wincmd w | wincmd J' $LOCAL $BASE $REMOTE $MERGED

  - vimdiff1:
      -f -d -c 'echon "..."' $LOCAL $REMOTE

  - vimdiff2:
      -f -d -c 'wincmd l' $LOCAL $MERGED $REMOTE

  - vimdiff3:
      -f -d -c 'hid | hid | hid' $LOCAL $REMOTE $BASE $MERGED

After this patch series, when one of these predefined variants is selected, a
fixed layout is chosen and translated into the final string fed into
"$merge_tool_path":

  - vimdiff --> (LOCAL,BASE,REMOTE)/MERGED
      -f -c "echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED

  - vimdiff1 --> @LOCAL,REMOTE
      -f -c "echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED
 
  - vimdiff2 --> LOCAL,MERGED,REMOTE
      -f -c "echo | vertical split | 1b | wincmd l | vertical split | 4b | wincmd l | 3b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED

  - vimdiff3 --> MERGED
      -f -c "echo | 4b | bufdo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED

Thus, we need to do two things:

  1. Manually check (one time operation) that the *before* and *after* strings
     are equivalent (from the point of view of vim).

  2. Add a unit test that verifies that the layout associated to each variant
     actually produces the string listed above. That way we make sure the
     functionality does not break in the future.

Step (1) is what I have already done (but I encourage others to do the same...
the more eyes the better).

Step (2)... is already done! Notice how, on the "run_unit_tests()" function,
these layouts correspond to test cases numbers #07, #09, #01 and #10 :)

  NOTE: While re-reviewing this, I noticed the layout definition for "vimdiff1"
        was set to "@LOCAL,MERGED" instead of "@LOCAL,REMOTE", which is the
        correct value. I'll fix this in v6.

Should this be considered enough test for backwards compatibility?

  NOTE: Another option would be to *completely bypass* the layout mechanism when
        using one of the old variants and, in that case, feed exactly the same
        string we were feeding before... but I just remembered we decided
        against that in v2... so back to the question above :)




