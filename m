Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E1F20188
	for <e@80x24.org>; Wed, 10 May 2017 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdEJSyQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 14:54:16 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35822 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdEJSyP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 14:54:15 -0400
Received: by mail-pf0-f172.google.com with SMTP id v14so2040473pfd.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AKHYqsVPAS1HR1tx3BOIf7+n+pxYT/ctUvLiLh3fBX0=;
        b=AG5yoHRs64lultLFmeh+72gfqg7LX5kFlYh3K7c6SFsS0KANcUnPIMqq7gI8Ni9Vfi
         u7H3REwVO+VGjBtad4LyXbOb4g81bL6NfhqHKAhH9aAfyix7r4qimwAA/Og8jLDz/ttx
         kvnTByRVY/OyFdGLTgORyZrC1TmjcUfEaP9npJlUBIw+6NrlJ4MtAjO5McrjpxVDzuWV
         q9vN3eM1XVzl/VaV0iscSsMLGkUxAGFLiJtxa5kMVTORHiWyVUieBygEYMvKu22F2KE4
         +ggJfHAFe9VQxxeSXj422sK7TcThJo628ChsvhNcuWVbPaMiB0li+8Iwo2gCGawhDHE6
         +YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AKHYqsVPAS1HR1tx3BOIf7+n+pxYT/ctUvLiLh3fBX0=;
        b=TaTaIDpap6lRbwSOwAHQyxgEPzRFrCkUPn059CrYd1jomimnWjRG88Z7m/GXYDW7sJ
         XljMbGnBlM54XcwB2OfBop762vXx2EVkqjflMooejb7IhkKpbvH5D6dYGj5iOXsA+b5b
         DsCz5X/Ag2U+BLuw0KOz+yp7tDu4CcTmt274CFQJTGz9k8ksIn7UfPskNaxfrjLqNCr+
         wUWlUxWXMgRet6L8TrAyH/eFc3R9GRajmW6ed9DdmZY82vGVVKbFZeV61Aw8iWxqg8qN
         QtvHei35BUKH5tJlFPOsZdQZNvoAV3ysL88heFr6E26pTXqanJTJtMJoFMjMUPl56Ids
         K/Sw==
X-Gm-Message-State: AODbwcAxmC7o+I70Jp2VB8VRbUcOZEBRFUcDOGafob9rc6hKKjhdn5jA
        7GD7XO5OJEuAxQ==
X-Received: by 10.98.206.201 with SMTP id y192mr7737479pfg.60.1494442454873;
        Wed, 10 May 2017 11:54:14 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:55dd:a079:3f06:9176])
        by smtp.gmail.com with ESMTPSA id l7sm9564514pgn.10.2017.05.10.11.54.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 11:54:14 -0700 (PDT)
Date:   Wed, 10 May 2017 11:54:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170510185412.GB28740@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <CACBZZX4AnmP2N_-WLtqQncUDCZDeWS3LFomZrWLYP6iW-hL5KA@mail.gmail.com>
 <20170510182049.GZ28740@aiede.svl.corp.google.com>
 <2839966.sklLQJ8GHA@mfick1-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2839966.sklLQJ8GHA@mfick1-lnx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 12:48:37PM -0600, Martin Fick wrote:
>> Ævar Arnfjörð Bjarmason wrote:

>>> Just a side question, what are the people who use this
>>> feature using it for? The only thing I can think of
>>> myself is some out of band ref advertisement because
>>> you've got squillions of refs as a hack around git's
>>> limitations in that area.
[...]
> Perhaps another use case is submodules and repo(android
> tool) subprojects since they can be "pinned" to sha1s,

Yes, thanks for mentioning that.  We've talked a little about making
'git fetch --recurse-submodules' use this feature, either always, or
if after the usual fetch the desired commit is not available in the
submodule.

Jonathan
