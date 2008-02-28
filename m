From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 33/40] When installing, be prepared that template_dir
 may be relative.
Date: Thu, 28 Feb 2008 10:49:15 +0100
Message-ID: <47C6839B.6090408@gnu.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 10:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfOp-0002sb-Jm
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 10:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbYB1JtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 04:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbYB1JtU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 04:49:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:14712 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbYB1JtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 04:49:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so214076ugc.16
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=J6jB3qYIO42KIi3zZ5SzQrB2Z5PGWvS+zM7JaLU+8Qk=;
        b=wXaAmBQwGsKDWtQLytMtzQtZtz1l79zOyCbD6AjGpULX/MI2Z7VZhsQLexcSHY73qlXg+UjFBfyXnl1c2TjK+HDoEfszxOA0uS3phNsEZkyNLuMQbe6E6Yo7bLIODYmzpL4w+YCCtdH0Z0bRgG8+XwYMmLGsV4VFtOfbgwR+Pms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=OOCdluJ60DljAu+HK8EnL4jXkQldMTncr8E3YqLtOSEYOhTV2MtNdWj68OW5kSpzkFQD+av/6dqZLqQNM+RJQ0SsLdiYoeZigxf03RFuje6FABvAHUA3NZ6OZCyTHp4FP2xpxycS2Z2J94c9z5leGlLYP5NVzg22blB2c9Dh7Bg=
Received: by 10.67.20.3 with SMTP id x3mr2997059ugi.3.1204192158182;
        Thu, 28 Feb 2008 01:49:18 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id y6sm16918895mug.1.2008.02.28.01.49.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Feb 2008 01:49:17 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75375>


> +ifeq ($(firstword $(subst /, ,$(template_dir))),..)
> +template_instdir = $(gitexecdir)/$(template_dir)
> +else
> +template_instdir = $template_dir
> +endif
> +export template_instdir

This is just a little more versatile:

ifeq ($(firstword $(subst /,
,ALONE-IF-ABSOLUTE$(template_dir))),ALONE-IF-ABSOLUTE)
template_instdir = $template_dir
else
template_instdir = $(gitexecdir)/$(template_dir)
endif
export template_instdir

Paolo
