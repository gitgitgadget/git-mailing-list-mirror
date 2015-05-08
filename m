From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri, 8 May 2015 21:38:06 +0100
Organization: OPDS
Message-ID: <BB246DF6A6DA4735B0B627F5555CB803@PhilipOakley>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com> <1431108819-6831-2-git-send-email-dturner@twopensource.com> <CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com> <CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "David Turner" <dturner@twopensource.com>,
	"Git List" <git@vger.kernel.org>,
	"David Turner" <dturner@twitter.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpBd-0000OK-9R
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbbEHUrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:47:55 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:60671 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753092AbbEHUrh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 16:47:37 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2015 16:47:36 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CCFAD9HU1VPDsFFlxSCoMOgTKDHoMubcUyBAQCgTVNAQEBAQEBBwEBAQFBJBuEGwUBAQEBAwgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBgESCAIBAgMBiB+1JoZSjSUsgSGKGYQoXYJvL4EWBZI7cIsVg1qHZ4lsgQSDFz0xgkYBAQE
X-IPAS-Result: A2CCFAD9HU1VPDsFFlxSCoMOgTKDHoMubcUyBAQCgTVNAQEBAQEBBwEBAQFBJBuEGwUBAQEBAwgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBgESCAIBAgMBiB+1JoZSjSUsgSGKGYQoXYJvL4EWBZI7cIsVg1qHZ4lsgQSDFz0xgkYBAQE
X-IronPort-AV: E=Sophos;i="5.13,393,1427756400"; 
   d="scan'208";a="155578395"
Received: from host-92-22-5-59.as13285.net (HELO PhilipOakley) ([92.22.5.59])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 08 May 2015 21:37:43 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268664>

From: "Junio C Hamano" <gitster@pobox.com>
> On Fri, May 8, 2015 at 12:45 PM, Eric Sunshine 
> <sunshine@sunshineco.com> wrote:
>>> +       if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & 
>>> GET_SHA1_ONLY_TO_DIE)
>>> +               die(_("internal error: bad flags for 
>>> get_sha1_with_context"));
>>
>> There may not be much value in marking an "internal error" string for
>> translation.
>
> The whole point of this kind of messages is so that the end users,
> when they see it trigger, can notify us and then to allow us to
> identify which die() triggered.  It is not just "may not be much
> value in", but is actively unproductive to make it translatable,
> even if we ignore the cost to i18n/l10n teams to translate such
> messages.
>
> By the way, we would want to standardise the string before the
> colon, so that we can tell users "If you see an error message that
> begins with 'internal error:', please report that to us---it is a
> programming error".  I think the majority of existing code uses the
> string "BUG:" for that, and I do not mind using 'internal error:'
> for that purpose instead, but the important thing is to use just one
> single string thoughout the codebase, so that the "please report
> when you see this" message we give the users can be simple.
>
I would see "BUG:" as being internationally recognised, while "internal 
error:" would need to be translated, and perhaps be written "internal 
error, report this to git@vger.kernel.org:" to ensure that the reader 
knows immediately what to do.
--
Philip 
