From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] format-patch let -k override a config-specified format.numbered
Date: Thu, 07 May 2009 18:03:28 -0700
Message-ID: <4A0384E0.4020506@gmail.com>
References: <8763gcri2c.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>,
	"Stephen C. Tweedie" <sct@redhat.com>
To: Jim Meyering <meyering@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 08 03:03:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2EV2-0001Js-W6
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 03:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbZEHBDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 21:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbZEHBDb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 21:03:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:54885 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbZEHBDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 21:03:30 -0400
Received: by rv-out-0506.google.com with SMTP id f9so871913rvb.1
        for <git@vger.kernel.org>; Thu, 07 May 2009 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=p7wp3wWpaa4jMtC5ANKfAVJDIfHRtuJ1rfiRy92zVgs=;
        b=WroVkub/3PS90xUacB3UrW6jtxSwRvgwiksfFprztbr+2cYD0Rx109rig6v7GBqcLW
         YlqJa2KEr/qWQZEyxz+dyH5irzJOWaULhDk9SnxoUty4Xl7R6NRaWVn/pZyHG0gyISG8
         EtvfMsQXCP132uAmWF3vIY90yz8rYHhR2s4fM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=chLd4c+DfWkGc6gYRAAcP27OjurmR4DywiTTMAFb0At12X/t/XZCcxE/MdLuwtkVPY
         YpmM2qJGJcE6eFWrxCS977UzHl5E/wCjNhxoIq5DeOFjs4v6S13pr9E64tIg7acNdB59
         DwgtcbG7ayzY2InLNFgOY4t9ANkQcMfi40NJg=
Received: by 10.140.157.1 with SMTP id f1mr1425117rve.196.1241744610606;
        Thu, 07 May 2009 18:03:30 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id k37sm813266rvb.38.2009.05.07.18.03.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 18:03:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <8763gcri2c.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118554>

Jim Meyering wrote:
> This started when a colleague reported that "git rebase master" was failing
> with a "fatal: -n and -k are mutually exclusive".  Stephen Tweedie discovered
> that it was due to the format.numbered=true setting in ~/.gitconfig
> conflicting with the -k of the format-patch command run as part of
> the rebase operation.  Here's a fix.

I think the real fix here should be in rebase. We should be passing
--no-numbered to format-patch. I was expecting 'format.subjectprefix' to
trigger the same bug, but it seems we don't set subject_prefix=1 in this
case. I imagine fixing that can be done in a later patch.
