From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Mon, 16 Apr 2012 17:34:29 -0500
Message-ID: <20120416223429.GA13440@burratino>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-4-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Tue Apr 17 00:34:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuVT-0007gB-0T
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab2DPWem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:34:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57697 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab2DPWel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:34:41 -0400
Received: by iagz16 with SMTP id z16so8035732iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MAMRiIuKhNQ8qAX4jV6naMD9DN/ivFlAj6iLKfX+1+Q=;
        b=XhHTyCY+dq2Tf32PHCzo1R5E6XPiYxaRXJFYcmtg9PUdqnuS721jIa+hLZEgtvNt5M
         76HFllfxnSWLSfdnkc6gTEzvzSFEXd6sdKqSbd5POmHqABsKxNhYqC7iqCE3v/gA0o3Z
         8hacqJDcuyLN9BbPt+lKa7a5iZBYXRBa9J4z6Eg1JaPgVlZaJ8OEc/u24JuzXp0bAOFz
         va9leYm+zEcZUReqtQ3/qDhDUDC+X6VozKrl03yCLoi/FRAKWdIlWNA51LgdKg9LTUAZ
         vdWjEhAUAF8mdEkOvHf0n8aettjJmLXEzH94NIuSu7DfKtmzbQ/ullJi64R9jGO61Dwa
         HHhA==
Received: by 10.42.180.66 with SMTP id bt2mr8420634icb.56.1334615681296;
        Mon, 16 Apr 2012 15:34:41 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hq3sm28364392igc.0.2012.04.16.15.34.40
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 15:34:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334614130-31826-4-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195717>

marcnarc@xiplink.com wrote:

> +		grep descriptive-branch actual | grep "[new branch]" &&
> +		grep descriptive-tag actual | grep "[new tag]" &&
> +		grep others/crazy actual | grep "[new ref]"

Careful. :)  I suppose the simplest fix would be to leave out the
brackets so the '[new ref]' tag is not misinterpreted as a character
class, like so:

	grep "new branch.*descriptive-branch" actual &&
	grep "new tag.*descriptive-tag" actual &&
	grep "new ref.*others/crazy" actual
