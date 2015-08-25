From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 15:50:16 -0700
Message-ID: <xmqqpp2bvv87.fsf@gitster.dls.corp.google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-5-git-send-email-sbeller@google.com>
	<20150825190329.GA11271@sigill.intra.peff.net>
	<xmqqfv37xfrc.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ9V35KmJSExt=EqYFcyOSysaFsJA0E+dx46Qg+Pm+Ybg@mail.gmail.com>
	<xmqq37z7xebe.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaMeaTiQgVxjf5aPAtLVw224Hf9gzDNS85+9C+rj_keWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:50:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUN2t-0006oj-5m
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 00:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbbHYWuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 18:50:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35542 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbHYWuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 18:50:17 -0400
Received: by pacdd16 with SMTP id dd16so137924340pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uzgcKw2cN9sBAH1jrjhtqFtNeD4C+70sYoGh/TKBKlA=;
        b=DknjqvZZzmuBr6OSPt74+aDyu7oj1AeuIpaKxUf8z9pc5ChuB7oxdkevFSb/42lndV
         Pk5fmiwBUUPXU0T5XTUv1ke/cbcJ0Otu9HKiVCG3y/FeAdqjGoYtOVZLlKsU/iCw2U0O
         hMz2QbaasG3cRTdYcgxNzi6VQfAYHjjMm2Sg0Cd2f+YO4Ho4yNSa4BYt1C2tsPrANoHr
         yNpaJczwgTlaFUEfp2NPIdxsLMYyUhTsFKtwDVFfYN07NXX4Vwi1nGHwdMWAM0xZ9+A8
         8QE3lxnw7TeVmuHgex9tupfMV1DVpX1Rwy/dOa+/UBOL71YWNfszAIs2xklEdLTzovdh
         PD1g==
X-Received: by 10.68.223.4 with SMTP id qq4mr19907536pbc.36.1440543017311;
        Tue, 25 Aug 2015 15:50:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id uz5sm12127211pac.1.2015.08.25.15.50.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 15:50:16 -0700 (PDT)
In-Reply-To: <CAGZ79kaMeaTiQgVxjf5aPAtLVw224Hf9gzDNS85+9C+rj_keWA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 25 Aug 2015 15:39:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276584>

Stefan Beller <sbeller@google.com> writes:

> Then please don't pick up this patch. This and patch 5 are there to convince
> Jeff this is a good API, worth being introduced and not over engineered, just
> solving a problem we're interested in with a minimal amount of code to side
> track from the actual goal we want to pursue.

Don't worry.  I did not have intention to queue index-pack and
pack-objects rewrite unless the use of the new API makes them
demonstratably better.

The criteria for "worth being introduced" would include "not
excessively heavyweight", I would think.  And it was good that we
have these two patches to judge if the earlier one (2-3/5) is a good
thing to add in a concrete way.  Perhaps the 2% slowdown might be
showing the performance characteristics of your worker pool model,
and Peff's suggestion to at least see (if not solve) where the
overhead is coming from was a very reasonable one, I would think.
