From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/32] split-index: strip pathname of on-disk replaced entries
Date: Tue, 29 Apr 2014 13:25:50 -0700
Message-ID: <xmqqlhunkhm9.fsf@gitster.dls.corp.google.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
	<1398682553-11634-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfEbW-0002AY-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 22:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbaD2U0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 16:26:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756244AbaD2U0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 16:26:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E74E7818E7;
	Tue, 29 Apr 2014 16:26:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lBAUU4C3aDZCEOifhhggNJT0VyE=; b=brd5VZ
	wmWq93KpzFXgi8Bu8Wt2QkMvwC7Vh2ZPnzEIu0AoKqJIMpFha1RKp0oJC/aaYSMc
	I/TIIdrKVQefLSTN52hMNsyKeRt+mQz6mf1t9vMFPQmLfk0S/hAoKT09iFoDoiRO
	rEEhwvJ0lAN/BjbRmUXqtISFCxbM+cjButMpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZGxVlf0LEZK1/7XkTkeK6/VyVgNNoDmc
	+uplbIpZ0H3hFRWL2HS8IqRtwzxxI9T9Afhf3Ljv5FRV6U2zhVCHeurTczeof30i
	TT0HaC1JDPO1N3Ip/mbUYiGXXqz56o97BQyKZ1quflDX4TrO7b4ewdJ6ZEDHf4qM
	AvorYCh1AFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D37C7818E3;
	Tue, 29 Apr 2014 16:26:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64532818D6;
	Tue, 29 Apr 2014 16:26:04 -0400 (EDT)
In-Reply-To: <1398682553-11634-25-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 28
 Apr 2014 17:55:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7CCC5AE8-CFDC-11E3-9991-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247608>

This triggers "saved_namelen may be used uninitialized" for me, even
though it looks clear that it is used under CE_STRIP_NAME and it is
assigned under that condition.  Sigh to a stupid compiler...
