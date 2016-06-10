From: David Turner <novalis@novalis.org>
Subject: Re: [PATCH v2 5/6] lock_ref_for_update(): make error handling more
 uniform
Date: Fri, 10 Jun 2016 15:01:19 -0400
Message-ID: <1465585279.8278.2.camel@frank>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
	 <6cc13da6767c5fd9dbf1b372634adf7c3a353464.1465544913.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 21:01:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBRgN-0000tm-OU
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 21:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbcFJTBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 15:01:23 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:47386 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcFJTBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 15:01:22 -0400
Received: from homiemail-a75.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 1DB82A716E
	for <git@vger.kernel.org>; Fri, 10 Jun 2016 12:01:22 -0700 (PDT)
Received: from homiemail-a75.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a75.g.dreamhost.com (Postfix) with ESMTP id 091A65EC080;
	Fri, 10 Jun 2016 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
	:subject:from:to:cc:date:in-reply-to:references:content-type
	:mime-version:content-transfer-encoding; s=novalis.org; bh=lkVOh
	W0uyOdoxlUFV6d7Nq4FLhQ=; b=O9mPDptxgTZAHza3RtLyJmjTurBMyx3HQw8v7
	A9cRXcq0AE5J9G9Lw5sITuSeiTTsQEDCl2qHtFK+VV+IHgThxXdCud0skMWm1sjV
	Jts2XbYuzBIP8qIuFg3NXog39nkbfFpStwhVPYH8a1VKeGJ24ryFHqVSYCrVaO+H
	uwV1QI=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a75.g.dreamhost.com (Postfix) with ESMTPSA id 4C9065EC07F;
	Fri, 10 Jun 2016 12:01:20 -0700 (PDT)
In-Reply-To: <6cc13da6767c5fd9dbf1b372634adf7c3a353464.1465544913.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297017>

On Fri, 2016-06-10 at 10:14 +0200, Michael Haggerty wrote:

>  /*
> + * Check whether the REF_HAVE_OLD and old_oid values stored in update
> + * are consistent with the result read for the reference. error is
> + * true iff there was an error reading the reference; otherwise, oid

"error" is not a thing here?
