From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 13:16:15 -0700
Message-ID: <xmqqpp5vm2cw.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<d21002e0fa92b03c3d417c8996328563@www.dscho.org>
	<CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
	<20150520182218.GD14561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 22:16:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvAPt-0006xz-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbbETUQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:16:29 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35913 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbbETUQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:16:18 -0400
Received: by iepj10 with SMTP id j10so48105188iep.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MOIVm77Hd9Pbvaoy5y9ohaEtCHBhZue61QZqMZlCN/4=;
        b=Ls0nUWiQ99hmWo521YQoj+V1nZZgUyw+lp/WG/GnP7G5ryIq4dtn0EhyrO8sNEsqta
         OICFSlgrSnqUbl76BniFWy+y7eSXxakRVTGSZSFIy4K17NE7b+IGHK6PJlVYDUejCyOa
         9czoQI0l6URZ3sojPTobzVbwNALxKkHp5R2VPFylgjQTxHFn331X7FRGq8vxR99OxfR0
         7lCXqbOI/spPI8ckEwmLgwk+we+HZHSjuDFZoI6LdaNWi9ONT+UM6T3QMQHKJddAW583
         9pQ0rNIQSw/jLA7nwxLmEeQz6tolEew0rEvDMj5Mh0WRKD00GT6rCUwKR2bM4av+21e2
         gM8Q==
X-Received: by 10.43.92.199 with SMTP id br7mr36289401icc.43.1432152977400;
        Wed, 20 May 2015 13:16:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id q78sm13127854ioe.9.2015.05.20.13.16.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 13:16:16 -0700 (PDT)
In-Reply-To: <20150520182218.GD14561@peff.net> (Jeff King's message of "Wed,
	20 May 2015 14:22:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269515>

Jeff King <peff@peff.net> writes:

> We could add a has_sha1_file() check in get_sha1 for this case.

Please don't.  get_sha1() is merely "I have this string, which may
be a 40-hex or an extended SHA-1 expression.  Turn it into a 20-byte
binary" and does not require you to have any such object.
