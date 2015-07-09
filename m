From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of .gitmodules values
Date: Thu, 09 Jul 2015 13:00:10 -0700
Message-ID: <xmqqoajlumnp.fsf@gitster.dls.corp.google.com>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
	<ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
	<CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
	<20150709120900.GA24040@book.hvoigt.net>
	<20150709154903.GA14320@peff.net> <559ECE6A.2070802@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:00:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDHzY-0001Un-2B
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 22:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbbGIUAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 16:00:16 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35379 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbGIUAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 16:00:14 -0400
Received: by iecuq6 with SMTP id uq6so183789917iec.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EVu2Qt/9yJZ8MOo+tyQqYMoojWIRVDjwUq3BdktWBy4=;
        b=intoF5gF0st4S1hZ1FRpqHyjZC0MM/O7u6yt40n6R/NNUGVaPorSlWWCZouHhhZ0oZ
         rFrUe28qd8pr8vn7XP+vHR8q5RRABWtrmazwk7QucIs5OjQHyVh5Hh0c6vsi2NiW52v9
         FHDXCCvxfwBF15u3irAsFnVSthVcxif7iEUw6RE+268e6awDxKnG4E/z4v2OjCDpMAuZ
         Bxqbu///rt5QRH8VviOlwZDJ/xFrffnltj+mFQ+9s3n5cL9EcmkEkJUBwy+lLZwP/01R
         mMxhqi62aLnP6fZFCLzz/jQNd5RyKlnb4fniE/TlkKtgjlvdDbBqsQej1UoaVlYGZsHb
         i6EQ==
X-Received: by 10.107.138.102 with SMTP id m99mr1599368iod.115.1436472012708;
        Thu, 09 Jul 2015 13:00:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id pg7sm17246174igb.6.2015.07.09.13.00.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 13:00:11 -0700 (PDT)
In-Reply-To: <559ECE6A.2070802@web.de> (Jens Lehmann's message of "Thu, 9 Jul
	2015 21:41:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273774>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> How does git-submodule access this information? It looks like it just
>> hits "git config -f .gitmodules" directly. Perhaps whatever interface is
>> designed should be suitable for its use here (and if there really is no
>> more interesting interface needed, then why is "git config" not good
>> enough for other callers?).
>
> The git-submodule script doesn't need this and is fine using plain old
> "git config", as by the time it is run the .gitmodules file is already
> updated in the work tree. Heiko's series is about adding infrastructure
> to allow builtins like checkout and friends to access the configuration
> values from the .gitmodules file of the to-be-checked-out commit when
> run with "--recurse-submodules". And yes, if we want to expose this
> functionality to users or scripts some day "git config" looks like the
> best place to do that to me too.

Did you mean "git submodule config"?
