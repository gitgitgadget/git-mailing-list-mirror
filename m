From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Tue, 08 Jul 2008 16:20:19 -0700
Message-ID: <7vbq18q7yk.fsf@gitster.siamese.dyndns.org>
References: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 01:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGMV9-0000j0-BN
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758509AbYGHXUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 19:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759380AbYGHXUc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:20:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759101AbYGHXUa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:20:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FE1F161F1;
	Tue,  8 Jul 2008 19:20:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6C137161EE; Tue,  8 Jul 2008 19:20:24 -0400 (EDT)
In-Reply-To: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
 (Robert Shearman's message of "Tue, 8 Jul 2008 23:18:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 737580B2-4D44-11DD-9095-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87807>

Robert Shearman <robertshearman@gmail.com> writes:

> Allow SSL to be used when a imaps:// URL is used for the host name.
>
> Also, automatically use TLS when not using imaps:// by using the IMAP STARTTLS command, if the server supports it.
>
> Tested with Courier and Gimap IMAP servers.

Sign-off?

> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index b3d8da3..e4a5873 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -37,10 +37,11 @@ configuration file (shown with examples):
>      Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
>  
>  [imap]
> -    Host = imap.server.com
> +    Host = imaps://imap.example.com
>      User = bob
>      Pass = pwd
> -    Port = 143
> +    Port = 993
> +    sslverify = false
>  ..........................

Don't we also want to keep a vanilla configuration in the example, or is
imaps the norm and unencrypted imap is exception these days?

Don't we need to support custom certificates, keys and CAs, just like our
code that supports https does, by honoring GIT_SSL_* environment variables
and configuration file entries?  The patch itself looks fairly clean, and
I'd like to queue this for wider testing, initially even without GIT_SSL_*
support.  But I'd like to see any patch with substantial amount of changes
properly signed off.

Thanks.
