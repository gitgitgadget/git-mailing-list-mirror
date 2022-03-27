Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9105CC433EF
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 18:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiC0SON (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 14:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiC0SOM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 14:14:12 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F513524C
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 11:12:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DC396320091A;
        Sun, 27 Mar 2022 14:12:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 27 Mar 2022 14:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=kuj02IXbPpaKCoNBCQcUQdYhJzT1BW3d4Lxn21
        kdH+s=; b=VFf/lmO4nyVLiklF2js8AbpTO8E4kLCYzksbv6u+PmUztJlbWnv0Ej
        fP2jBRPWbk5XhRPqi4JKD4gbwE9IumUKTzOKmJ16p/PFZoxkxn7b8DTcvi57Rd71
        FHMwS9WNQjFt0Pjw0tWDLmDp4AsbVfa3SmpyxAl9qPTRD1Qy3kBAt7Ke3W+3EDKX
        iTXCh3tdox1bG8rKE1tKkayJdsmq1nTLjMPk5mIBQ9FR/zFH8nHm5sA08U0DyqFF
        9icmlpUhOykFJCm9HkvfF1Xis+aDRdcJ5WMlOB5li8yGxF7quzf0oVTN8vtdIN8n
        HC8w1gARMLmoMbIDe1K2uinRWC2gQHTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kuj02IXbPpaKCoNBC
        QcUQdYhJzT1BW3d4Lxn21kdH+s=; b=EtLLqANvQ4E0SpHzQUna2JDd7n/tHbLb5
        MioHXtMAy/npRRjh0tuFDu+1z4F38E2chM/H5WrwqfusUk7wsKdHhnfUoK+ttpVx
        k+BEJ9Fz3DH8jYxe2UBypkc7KY4cT3EyQag1uExrTH1Iaync09Q8Jo0zw1KgA4Bo
        G2kXKO8+y5N/AMuySxvVNypIEqgXobmfh8IBvJz9OMzpN9GK0G3L9wi2cuH0qBiu
        dDdpZiGTygdlWN1NuzmPIzyEkxgOQ0PpKHs6rJ0JYn5LdqAp1mvSKzKlaISB4LO5
        Kd7MQQZX/uZIFi1ToAtAOCOEgUx6iaaHMaMb8Uq6T3TPB8Muf8DZA==
X-ME-Sender: <xms:DalAYhHeWsu5hIab0NCCRDoeVmbsPj6vgsV7399gBTjCoElW8G_AZQ>
    <xme:DalAYmXv1fb2HGyC5kZgI1jTGZXmUfHBNsF3l2WSDtU_kQKaDNkTFOvzQYn4Rbzz2
    p0nf1VQf2ZN6btvnA>
X-ME-Received: <xmr:DalAYjIEqIwgnccQJoyuUu_336t6a4xwQsvoUvCUlt8Hefs107D5UK7TYu8Rp9-7R0XEIuofaHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehhedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepvdejieeflefhteeihffhtdfhfeekhffhuedttedvgfevgfevfeehfffgkeej
    feehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:DalAYnEhSlZfL0wzEiTITlVt_c9wkvUCRGZxn6M9WT-dTpOFqncvtA>
    <xmx:DalAYnWHC2YSY4Fb9bubnwABgJYymJqt0L6LVVvZsJmiWabqChSVdw>
    <xmx:DalAYiNnXqUGPs5it0sIoUxnM8CSxITpBbhJZAlcFFOBtVp1gN6tBA>
    <xmx:DalAYtenq8GY7f5Ut4TiclLm6l_dMSOcLBG7UPssFcb4vxl_QdqC9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Mar 2022 14:12:27 -0400 (EDT)
Date:   Sun, 27 Mar 2022 20:12:24 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v6 1/3] vimdiff: new implementation with layout support
Message-ID: <YkCpCJfX/xdp+P7r@zacax395.localdomain>
References: <20220327112307.151044-1-greenfoo@u92.eu>
 <20220327112307.151044-2-greenfoo@u92.eu>
 <00463195-5514-bf2b-e733-24e1e24a70cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00463195-5514-bf2b-e733-24e1e24a70cb@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +################################################################################
> > +## Internal functions (not meant to be used outside this script)
> > +################################################################################
> > +
> > +debug_print () { 
> > +	# Send message to stderr if global variable DEBUG is set to "true"
> 
> This should also be GIT_MERGETOOL_VIMDIFF_DEBUG, right?

Good catch! I'll fix it in v7.


> > +gen_cmd () {
> > +	# This function returns (in global variable FINAL_CMD) the string that
> > +	# you can use when invoking "vim" (as shown next) to obtain a given
> > +	# layout:
> > +	#
> > +	#   $ vim -f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> > +	#
> > +	# It takes one single argument: a string containing the desired layout
> > +	# definition.
> > +	#
> > +	# The syntax of the "layout definitions" is explained in ... (TODO)...
> 
> Is this still TODO ?

No. I need to point to "Documentation/mergetools/vimdiff.txt".

I also noticed that the next paragraph was also not updated after the delimiters
were changed (from ";", "-" and "|" to "+", "/" and ",").

I'll fix both issues in v7.

Thanks!
