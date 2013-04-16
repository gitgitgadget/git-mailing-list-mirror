From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Tue, 16 Apr 2013 08:25:24 +0100
Organization: OPDS
Message-ID: <99AE5E981E2547B6A71A4D77B17167B9@PhilipOakley>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org> <7v8v4k6hp2.fsf@alter.siamese.dyndns.org> <79879228B71A45A48A961F5B1880B61F@PhilipOakley> <7vli8k4lnj.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 09:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US0Gb-0005qZ-3i
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 09:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157Ab3DPHZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 03:25:20 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:35857 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570Ab3DPHZS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 03:25:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AswOADj8bFFOl3gj/2dsb2JhbAAuGAqDBjaIb7gNBAEDAYEGF3SCGgUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYd9CqwQkDONWwVNaoJnYQOITYV0mVWDDDuBLw
X-IronPort-AV: E=Sophos;i="4.87,484,1363132800"; 
   d="scan'208";a="425187089"
Received: from host-78-151-120-35.as13285.net (HELO PhilipOakley) ([78.151.120.35])
  by out1.ip02ir2.opaltelecom.net with SMTP; 16 Apr 2013 08:25:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221374>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, April 15, 2013 2:39 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> If the "parsing" is done for white/blacklist purposes, is there a
>>> need to straight-jacket the verison string format like this series?
>>
>> The purpose is to document what we felt we could guarantee, and that
>> which was open to variation, so that those, like the Git-Gui, can
>> code
>> in a sensible check for the version. Two digits (X.Y) should pass the
>> existing Git Gui check.
>>
>> I'll drop the length limit, and keep to an X.Y check
>>
>> Is the end of t0000-basic.sh a sensible place for the check?
>
> Sorry, but I still do not understand what you are trying to achieve.
>
> What kind of benefit are you envisioning out of this?

The purpose of tests is to detect mistakes and spot regressions.

A change to the 'git version X.Y.z' string would be a regression, as I 
spotted earlier, as it conflicts with expectations of standard 
programmes such as git-gui.

>For a future
> version, people would not know what incompatibilities it would
> introduce, so
>
> case "$(git version)" in
> "git verison"[2-9].*)
>        echo unsupported version
>                exit 1
>                ;;
> esac
>
> is a nonsense check.
>
> For all released versions, people know how they looked like
> and we
> do not have anything further to specify.  Git 1.5.0 will forever
> identify itself as:
>
> $ git version
>        git version 1.5.0
>
> Worse yet, for an untagged version, you may get something like
>
> git version 1.8.2.1-515-g78d2372

However, if it passes the test [all the tests], one expects it will be 
reasonably (almost completely) compatibility with external expectations, 
such as those of git gui.

The questions I'm posing is from the other direction - use of tests for 
quality control.

>
> and it may or may not behave the same way as 1.8.2.1 depending on
> what trait you are interested in.

That will depend on the tests if [deliberately?] failed.

I'll tidy up the patches and commit meesage and see how it looks then.

Philip
