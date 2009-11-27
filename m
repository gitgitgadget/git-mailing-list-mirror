From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] status -s: respect the status.relativePaths
 option
Date: Thu, 26 Nov 2009 19:15:51 -0800
Message-ID: <7vljhsy7x4.fsf@alter.siamese.dyndns.org>
References: <cover.1259248243.git.git@drmicha.warpmail.net>
 <62c5bb36940485deefbf73f4bdc3fd45bbea069e.1259248243.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 04:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDrJZ-0004WT-7z
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 04:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbZK0DP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 22:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbZK0DP4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 22:15:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZK0DPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 22:15:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D160EA12EB;
	Thu, 26 Nov 2009 22:16:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+F7T5QcZpfa3/xBzWrU6/2W8Kx4=; b=qosLU8
	tK538zsR04wnhHkP70u1FAMcnX8PkwpeMeG+GFR7s5UvtaE9PyJXLFR2PBBMcYZs
	7qA0ywTUgSd073e8iT6KY0lHFvQ7+tcCI+On5AmtfGU9NUq2nUR9XDPEvEswzGLI
	xxwMLawdeC042e+2SKC9Z84yU8QPgpp77hjRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GQgwp2RqLNSsVqV1PwOAOPDzl3e2IS0W
	au4rekfmCB547kuUhh+gFVWvcK+9kIRIe0vseZshX5EvNSu+lAQX8xbngCNM5RUw
	lGZvU6ix3SY+10b6kIrCrFyAZh+7Xl8zsJQXKHikgR2ipaQ5ItKgELz2aDJ1O0LM
	o3Vk0lLif8Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86C6FA12EA;
	Thu, 26 Nov 2009 22:15:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E1A84A12E8; Thu, 26 Nov 2009
 22:15:53 -0500 (EST)
In-Reply-To: <62c5bb36940485deefbf73f4bdc3fd45bbea069e.1259248243.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 26 Nov 2009 16\:24\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2ED898C4-DB03-11DE-A59E-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133855>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> so that 'status' and 'status -s' in a subdir produce the same file
> names.

This configuration is on by default which makes this change even more
important.

I'd squash this in and queue it at the tip of jk/1.7.0-status topic.

Thanks


diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 58d35fb..b3dfa42 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -114,8 +114,8 @@ compatibility) and `color.status.<slot>` configuration variables
 to colorize its output.
 
 If the config variable `status.relativePaths` is set to false, then all
-paths shown in the long format are relative to the repository root, not
-to the current directory.
+paths shown are relative to the repository root, not to the current
+directory.
 
 If `status.submodulesummary` is set to a non zero number or true (identical
 to -1 or an unlimited number), the submodule summary will be enabled for
