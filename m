From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Tue, 02 Jun 2015 10:06:18 -0700
Message-ID: <xmqqoaky3ur9.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-12-git-send-email-sbeller@google.com>
	<xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
	<xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
	<20150529222120.GB15678@peff.net>
	<CAGZ79kaRTLX7eBCOA=yQHVwcN-H-o_aZFfQ1gw7Nx-NC82pbag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:06:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzpdy-00036e-9n
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbbFBRGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:06:22 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36850 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbbFBRGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 13:06:20 -0400
Received: by ieclw1 with SMTP id lw1so42739578iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GN8XdWapjFa5Tf8p/C2E6Mw77doDunA9WFsz9gJ9DHQ=;
        b=oQtAaR8+WWl1iq8rUUIYkZQzTohI/PMDmAG61KThWvhojwp4ozqnoR+IoXK1r8pVnt
         tzKqgz/3OSuMlYcUD2X/dQtQCtx2IhplAJjTZuTqtEQ907+Ezw0kQU0BT1aTniCWIS0L
         +Yo3DgzWxFt+UyBXq/btOu0+l26Waj2xKHbTX/SyyjpeWInR9/ZBc8dJN5IG9C29YZ2f
         BOTLKAplr/iYWijcZs4gW3MtI/GikaPOmtSwAcl3Fhv+zh+qjl/fLunj38Ffd0uhGNTJ
         dLksAFrJypv08G2FG6Zt5xbrjBwOfYXczsf0FnC9xJLbXHuTLCOYRJ/t+m2GLaBLo72W
         76Mw==
X-Received: by 10.50.114.9 with SMTP id jc9mr21441359igb.49.1433264780176;
        Tue, 02 Jun 2015 10:06:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id i4sm10492800igm.2.2015.06.02.10.06.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 10:06:19 -0700 (PDT)
In-Reply-To: <CAGZ79kaRTLX7eBCOA=yQHVwcN-H-o_aZFfQ1gw7Nx-NC82pbag@mail.gmail.com>
	(Stefan Beller's message of "Mon, 1 Jun 2015 16:14:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270563>

Stefan Beller <sbeller@google.com> writes:

> I think the recent issue with the push certificates shows that having arbitrary
> data after the = is a bad idea.

I do not think push certificate episode tells any such thing.

It was about not carefully using cryptography with arbitrary data.
How that arbitrary data came to the machinery is irrelevant.  We
could have used base-64 to encode the server nonce when transferring
it to the machinery via capability, but then decode it in order to
place it in the cerficiate.

Do not restrict transport for such a reason and make legitimate uses
of the transport unnecessarily harder for later users.  What needs
to be done is to think how the data that was transport was used.
