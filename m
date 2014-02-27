From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] GSoC2014 microprojects #6 Change bundle.c:add_to_ref_list() to use ALLOC_GROW()
Date: Thu, 27 Feb 2014 17:31:19 -0000
Organization: OPDS
Message-ID: <D5ECFBC97E4246CBB939B7670259D3DC@PhilipOakley>
References: <1393517894-670-1-git-send-email-sunheehnus@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <mhagger@alum.mit.edu>
To: "Sun He" <sunheehnus@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 27 18:31:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ4nu-0005om-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 18:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbaB0RbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 12:31:19 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:53852 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753452AbaB0RbR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 12:31:17 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwXAG91D1NZ8YVX/2dsb2JhbABagwaJU7hFAQIBAYEaF3SCIAUBAQQBCAEBHREeAQEhBQYCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYdUAwkMw2QNhwoXjD+CFoMqgRQBA4kShh2FHoF+jEGCD4VHgW+BPjw
X-IPAS-Result: AvwXAG91D1NZ8YVX/2dsb2JhbABagwaJU7hFAQIBAYEaF3SCIAUBAQQBCAEBHREeAQEhBQYCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYdUAwkMw2QNhwoXjD+CFoMqgRQBA4kShh2FHoF+jEGCD4VHgW+BPjw
X-IronPort-AV: E=Sophos;i="4.97,556,1389744000"; 
   d="scan'208";a="451162760"
Received: from host-89-241-133-87.as13285.net (HELO PhilipOakley) ([89.241.133.87])
  by out1.ip03ir2.opaltelecom.net with SMTP; 27 Feb 2014 17:31:15 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242832>

From: "Sun He" <sunheehnus@gmail.com>
>
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
> bundle.c |    6 +-----
> 1 files changed, 1 insertions(+), 5 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 7809fbb..1a7b7eb 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -14,11 +14,7 @@ static const char bundle_signature[] = "# v2 git 
> bundle\n";
> static void add_to_ref_list(const unsigned char *sha1, const char 
> *name,
>  struct ref_list *list)
> {
> - if (list->nr + 1 >= list->alloc) {
> - list->alloc = alloc_nr(list->nr + 1);
> - list->list = xrealloc(list->list,
> - list->alloc * sizeof(list->list[0]));
> - }
> +    ALLOC_GROW(list->list,list->nr,list->alloc);
>  hashcpy(list->list[list->nr].sha1, sha1);

Isn't this on top of your other micro-project patch?

If so, it is worth including a note after your signoff and --- to say 
that, so they get applied in the right order :: The principle of least 
surprise.

>  list->list[list->nr].name = xstrdup(name);
>  list->nr++;
> -- 
> 1.7.1
>
> --
Philip 
