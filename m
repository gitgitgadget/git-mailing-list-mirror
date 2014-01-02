From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Thu, 2 Jan 2014 14:28:33 -0800
Message-ID: <20140102222833.GR20443@google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228222129.GE5544@google.com>
 <xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
 <20131230185125.GI20443@google.com>
 <20131231103323.GA14823@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 02 23:28:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyqku-0000dv-6u
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 23:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbaABW2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 17:28:40 -0500
Received: from mail-gg0-f172.google.com ([209.85.161.172]:50246 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbaABW2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 17:28:38 -0500
Received: by mail-gg0-f172.google.com with SMTP id q6so2913678ggc.17
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 14:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gRIbOSgrV2wY0Ho2BnNiREvFIqeDbjsVA7SGRbxjKSo=;
        b=P/Ofo5WKBwpoxZWRzTS5etrAMPm51jV1Z7cudq+j+fpDPgALodWRV7in/qzOjCeTYi
         0NwMR0U9AyGcF+nMjLkhRl3QR9QyXMqCYe3Q8udJ7S9hIVMgJyjRyi/dCVYAs0E3lUVw
         +7En+W2dHbamsxc2flZ2/6hBUZ/3W5lINzJO6c0qyWwFITXQ0wYDRRKUE71F40VGEzME
         DgaTmsycqUZAc+ga3souwidSSrp7Jk+6CVaNQhCVcr22tImeHN6hAx0AH25sZSwni2q0
         qwa2JxFm/9mmQlUsBaQG3duPPA/cvA/ebbPOV6Y3l52iT15SUOeEkFQ5wCYea4BGFFZx
         tCaw==
X-Received: by 10.236.90.65 with SMTP id d41mr60008194yhf.28.1388701717165;
        Thu, 02 Jan 2014 14:28:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id g26sm153339yhk.3.2014.01.02.14.28.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 14:28:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131231103323.GA14823@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239892>

Jeff King wrote:
> On Mon, Dec 30, 2013 at 10:51:25AM -0800, Jonathan Nieder wrote:

>> 	These scratch areas for sub-tests should be under the t0000
>> 	trash directory, but because the TEST_OUTPUT_DIRECTORY
>> 	setting from the toplevel test leaks
[...]
> This is not exactly true. The TEST_OUTPUT_DIRECTORY setting does not
> leak. t0000 sets $TEST_DIRECTORY (which it must, so the sub-scripts can
> find test-lib.sh and friends), and then TEST_OUTPUT_DIRECTORY uses that
> as a default if it is not explicitly set.

So I should have said something like the following instead:

	These scratch areas for sub-tests should be under the t0000 trash
	directory, but because TEST_OUTPUT_DIRECTORY defaults to
	TEST_DIRECTORY which is exported to help sub-tests find test-lib.sh,
	the sub-test trash directories are created under the toplevel t/
	directory instead.  Because some of the sub-tests simulate failures,
	their trash directories are kept around.

	Fix it by explicitly setting TEST_OUTPUT_DIRECTORY appropriately
	for sub-tests.

Thanks for catching it.

Jonathan
