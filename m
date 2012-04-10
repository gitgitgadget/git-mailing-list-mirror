From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Tue, 10 Apr 2012 09:04:21 -0500
Message-ID: <20120410140421.GC2444@burratino>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
 <7v1unwwwov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ross Lagerwall <rosslagerwall@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 16:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHbgM-0000hx-D5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695Ab2DJOE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 10:04:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57434 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab2DJOEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:04:25 -0400
Received: by obbtb18 with SMTP id tb18so7290394obb.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YhJYhQYkDZJL9z0ZSMqEglKrao61mCg74FoOBggF+Vw=;
        b=KCmhu+rZFjnYmuiGv00h1n4kysnZQvXA8dfkKCC2kW7ZL58ZlUZCGX+xO+tJLN/2as
         uDbiWe8vmLW1x2Sv/QVNT5y+kvmwx8zvUnBTtcQgNg7JQfVVqBCIUcVzm/lS+G1QkV59
         0DN7rFYGTjkgMCNNFGt5pFcsUN7416pjjufRsjUGPQtc7i0fTuJ4gwJrHud+BeU+Y1S/
         ouRo5l/GnuxXlpYl06iRE+O1UHHqYwO9mYNbFzygnAMFIb0Ro3Ghrgioix7lkYcnlEMV
         03oNOFXE6SMaAdH6ZPgqfbV+a0N4VzyGnaK2zJGOUmkacO1RObr0SyAvQmg878EXuz7E
         /idA==
Received: by 10.182.122.36 with SMTP id lp4mr16254992obb.64.1334066664739;
        Tue, 10 Apr 2012 07:04:24 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yv3sm19795813obb.3.2012.04.10.07.04.23
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:04:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1unwwwov.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195083>

Junio C Hamano wrote:

> But it will break existing scripts if they expect the following to work:
>
> 	file="$(git rev-parse --show-prefix)/$1"
>         cd_to_toplevel
>         test -f "$file"

Huh?  I tried this:

	$ foo="$(printf '\n')/bar"
	$ printf '%s\n' "$foo"
	/bar

If that didn't work, it would mean that "git rev-parse --show-prefix"
would never work when the prefix is nonempty, because it is followed
by a newline.
