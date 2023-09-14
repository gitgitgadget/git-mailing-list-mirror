Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BFFEEAA71
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 20:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjINU0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjINU0F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 16:26:05 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3613E26B2
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 13:26:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7310C3200413;
        Thu, 14 Sep 2023 16:25:58 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 14 Sep 2023 16:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1694723157; x=
        1694809557; bh=dr4slInlyAIjKFyANht5OyYxC+Md1IQD7R+PJtu8w/w=; b=l
        kfWugG59VHzG9UQCGG3STQP7h+rmbTe8dumqnWuE7yQL+7wiGLl7qo2g5C2SUDJK
        RQBhUa3NkF8Kbp2BBgzZV0Pr/nF25TWO3y82XEVyFXBlvhvIYHgqqxvg4wYwFsdJ
        873rTbAQQUh8/+/yRxzLWQdEKlGM7WJdtRJ3yoFXFdb4OrUz19BA2ZSED6YPk5GO
        uOi8Iskq35PdqFyqAXKe1mAAbCDrP2mcgGjNPf/Ho6DauYEePU9dYfUquMtWdGKW
        bpt4BKHbyxbdeaL9nm2YI0JqbZMzMMxccvQ9+zal3XJe7lwv3JJev9e/1Sz9CoHz
        39I0cwhzmRJ7WD7L5LqsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694723157; x=1694809557; bh=dr4slInlyAIjK
        FyANht5OyYxC+Md1IQD7R+PJtu8w/w=; b=jdtk5+c9WitmGrATSJyeP6MCtpL3/
        DqcqF4sKyDD5z/0ajnNL+4PsANGCy051q4U3PLIvGiCvo7zhXwMq7wqnR5D4U/3l
        6xdljPpnOBZUf3P91rBMQkaA4uc0klpt9YXw1WyH23Bf7V11LTUv4Ow6tmT1O1oU
        eT2h1T0UuRMGmiGU4RwRMkBgr+WfWMGT9Y4Obx4oe6nhk+R6+6BIOFOopGo8MEzU
        8d9Jd81Sr66HnxPBlImRpCynOC8M2hOX8auEyFy0zGkXe+2IbUAJRfxB+Ulv453P
        2Qcegx5huYy6r7MmQaIRgh5bd1Rb50Kmyk7UZJu7JPN4ZzeYbDcbTCvMw==
X-ME-Sender: <xms:VWwDZT4Bw9ihe_RwDFbldjVFJvbmhl4NmQTaEZOV6Rrqb0tWgHJG2J8>
    <xme:VWwDZY5XQ69GJX2Tk9-1IkrTL5jK0e1otJngOTuFTb3tENRqGiAe67KzFijrtvFeF
    Xis6votQHQDmrSlSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VWwDZacznvKdgEky_9ktJe3S-Ah60_pVqV9OKMLd43mtJc9-JkJz3Q>
    <xmx:VWwDZUJ0myTEVcUIwhLuXNui8EyATp-YXVIMfMR4z-cMaXyXlCyARg>
    <xmx:VWwDZXKQv-XxU-q60o5J55daorRs-gVtUvJzgXr7TchMzesy3lN1kg>
    <xmx:VWwDZeV5rQP0El9QV5mvMYbXWEUkoi6fSDFtdOu2PJ5hMl9qPIDUBA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B4CAF15A0092; Thu, 14 Sep 2023 16:25:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <c7d1e196-9521-45a7-b41c-80499f19f546@app.fastmail.com>
In-Reply-To: <dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de>
References: <cover.1693584310.git.code@khaugsbakk.name>
 <cover.1694383247.git.code@khaugsbakk.name>
 <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name>
 <xmqqzg1strgx.fsf@gitster.g> <dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de>
Date:   Thu, 14 Sep 2023 22:25:37 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, "Denton Liu" <liu.denton@gmail.com>,
        "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] range-diff: treat notes like `log`
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023, at 10:29, Johannes Schindelin wrote:
>> [...]
>
> Right, `-G --notes` is a good argument to rethink this.
>
> A much more surgical way to address the issue at hand might be this
> (Kristoffer, what do you think? It's missing documentation for the
> newly-introduced `--show-notes-by-default` option, but you get the idea):

Looks good to me. It seems like an explicit argument is the only way to
make this work.

-- 
Kristoffer Haugsbakk
