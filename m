From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 6/9] For each exclude pattern, store information about where it came from
Date: Sun, 2 Sep 2012 23:36:59 +0100
Organization: OPDS
Message-ID: <A05E4811A66D499DA6AC932AC49F1E8F@PhilipOakley>
References: <1346544731-938-1-git-send-email-git@adamspiers.org> <1346544731-938-7-git-send-email-git@adamspiers.org> <997D30474124498FBFBA89C2E20F7773@PhilipOakley> <7vipbwgnnv.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Adam Spiers" <git@adamspiers.org>,
	"git list" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	=?iso-8859-1?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 00:38:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Inn-0002nK-DG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 00:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab2IBWhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 18:37:03 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:46881 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755240Ab2IBWhC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2012 18:37:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnMSABTEQ1BZ8rU+/2dsb2JhbAA7CotErlkBAQEBgQCBCIIbBQEBBQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQaBgcXBhMIAgECAwGIALoUiw0QLWZpGxkHgQqCcmADiBuFQ5gVgmQ
X-IronPort-AV: E=Sophos;i="4.80,356,1344207600"; 
   d="scan'208";a="549529902"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip06ir2.opaltelecom.net with SMTP; 02 Sep 2012 23:37:00 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204678>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, September 02, 2012 8:02 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Is there a way to identify the config core.excludesfile if present?
>> i.e. that it is from that config variable, rather than directory
>> traversal.
>
> If the code handles $GIT_DIR/info/exclude then that configuration
> would also be handled the same way, no?

Probably not. The $GIT_DIR/info/exclude is directly a path, while the 
core.excludesfile could point anywhere. This assumes the path to the 
relevant ignore file is shown.

Given the suggested report format in the Documentation, this path could 
be reported as 'coreexclude', not just an 'exclude'.

If I've understood the regular code correctly, the core.excludesfile is 
always at one end of the exclude struct so should be easy to check at 
that position. 
