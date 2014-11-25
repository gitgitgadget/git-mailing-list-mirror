From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Tue, 25 Nov 2014 12:36:43 +0100
Message-ID: <8034833.1FhY2A8KSQ@al>
References: <6997784.RuzRO1AFsK@al> <283403992.8FOSVk7RPR@al> <20141125040826.GC19301@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 12:36:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtEQR-0002KS-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 12:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbaKYLgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 06:36:51 -0500
Received: from lekensteyn.nl ([178.21.112.251]:54104 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700AbaKYLgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 06:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=2u7hg5ImxqT1O92BSs0ZU25yGNwM3KzinOxYFp1HOxc=;
	b=U3LRzafFOblsoTFBxIwjwm+ftbrrekF+OKKJiGHrOf3ZGVYlsBMMVOVEUik4TomMESGeXi92efJm7a7iXgonh1RNEZSoLDrh1XfG1VFWXJNBjgi0boQyDVIcHGXyUVT0xXnaf4UI9itvh1r0csPiL6zDgpcoJUSrTbS0vcUWVJGnAKAtt1GzXwrKVhZRk6XA5a1TTcujc8FaUo/UXWrl+0jAR2hxgzsx6AiKFJ/IbtYW05RsgIc4s4/JqrMRRODj4pInjlWsf9iXMMrvBBPrrNQJSJ9MXv33GI5RbxLWndmC9w55LZ9zdyym/NttDv4rrgJReTSHWQe/mMz+lbK2kg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XtEQG-0000Az-9r; Tue, 25 Nov 2014 12:36:44 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <20141125040826.GC19301@peff.net>
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260210>

On Monday 24 November 2014 23:08:26 Jeff King wrote:
> However, I think what removed the confusion for me in your --only=both
> proposal was the presence of a "both" option, since it made it more
> clear that is not what no-option means. So what about just "--push",
> "--fetch", and "--both"? Explain the current behavior of no-options in
> the documentation as a historical oddity.

Ok, this sounds even better. I have dropped the --only part and made the
options --push, --fetch and --both disjoint (overriding each other). A
patch will follow soon. Maybe it should warn when you try to specify
both options though.

> That also gives us an easy path forward for changing the behavior.
> During the transition period, people should use --push, --fetch, or
> --both. Using no-options provides a warning. After a settling period,
> the no-option behavior will switch to one of those (presumably --both),
> and drop the warning.
> 
> You do not have to do the migration path if you don't want to. Adding
> "--fetch" and "--both" scratches your itch and sets us up to migrate
> later.

I have documented the historic behavior and mentioned that it is
/possible/ that the option --both becomes default in the future.

> > What about the translations? Should I send a separate patch for that or
> > can I update all translations at once?
> 
> You do not have to update the translations. When we near a release, the
> l10n coordinator will run "make pot" to update po/git.pot with the
> strings marked for translation, and then the translators will write
> translations for the new strings. You are of course welcome to help with
> the translation effort at that stage. 
> 
> Details are in po/README.

Well, it is not necessary the translations, but the format of them. The
format
"git remote set-url --delete <name> <url>" has changed to
"git remote set-url [--both | --fetch | --push] --delete <name> <url>"
for example. The old strings are still usable, so I wonder whether I can
make it easier for the i10n maintainer to recognize this change?
-- 
Kind regards,
Peter
https://lekensteyn.nl
