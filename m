From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 07/11] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Sun, 27 Jan 2013 19:08:58 -0800
Message-ID: <20130128030858.GJ8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-8-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:09:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzf69-0004ke-Jw
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 04:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3A1DJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 22:09:08 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60029 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab3A1DJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 22:09:06 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1193987pbc.21
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 19:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dEXsOd7rc24/r7rGa6RxDy1uN/PJRMc57L6ltCY8LIc=;
        b=QcAGWKVmvbdlhXgB7c3dHEVcj4v5sCMujcxo4Ox2yXbvFS21NQY4JwAqkV2zKdd5KK
         GqX9qFoItmXtAxLz2RYW4Wn+8GLSr47MvZawm4E50LAvzvWDk7lRAAxPHNLUrzkM7B8x
         7G7JSR2W9TlubXL61VkpXLcwpV9wI6F9UcW/5fF8ZgVfj1kTYXkFSwUvD3dTSno6G0HO
         4BbTumXEB+/0/TMKUAgQ1D3jifyNUVLv9Fq+Lof6Ryq0YifVOy5T4yJb1ajIBH9K5TTT
         FWlttpBvCCmvVqmHiYRFiTgf310qYJzvLY2I3pSujD/Ls1SMTJlEVNJL+p2kR6trcaQ8
         PVKg==
X-Received: by 10.68.233.201 with SMTP id ty9mr34742193pbc.14.1359342544668;
        Sun, 27 Jan 2013 19:09:04 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id y9sm5804041paw.1.2013.01.27.19.09.02
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 19:09:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-8-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214794>

Brandon Casey wrote:

> Teach append_signoff how to detect a duplicate s-o-b in the commit footer.

This replaces the previous (slightly broken) logic that checked
whether the sign-off to be appended would be redundant and puts the
fixed logic further down the call-chain next to the rest of footer
parsing.

I am not thrilled with the

	0 = no rfc-style footer
	1 = rfc-style footer, no sign-off found
	2 = rfc-style footer, sign-off found but not as last field
	3 = rfc-style footer, sign-off found as last field

convention but since it's local to sequencer.c and this logic to scan
all lines for the sign-off can probably be ripped out soon I don't
mind.

The general direction is good and the execution looks obviously
correct.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
