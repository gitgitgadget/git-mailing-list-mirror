From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Introduce new build variables
 INSTALL_MODE_EXECUTABLE and INSTALL_MODE_DATA.
Date: Thu, 31 Jan 2013 07:48:32 -0800
Message-ID: <7vy5f9ica7.fsf@alter.siamese.dyndns.org>
References: <5109D230.2030101@iam.tj> <20130131132526.GA10622@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: TJ <git@iam.tj>, git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 16:49:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0wNn-0000et-TV
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 16:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab3AaPsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 10:48:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab3AaPsf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 10:48:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B398BD9DB;
	Thu, 31 Jan 2013 10:48:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WhVwdIN5ir2ecrjeEQ+4uH8fDm0=; b=Uw96MD
	4b+PKltJY/LUDrSdBEk4UFQgkiS/XdbPQDK0WmKxwGIvrfnAkR7QrrySfuKZ/5g1
	EHQyrxtLPO+SMXdDUnKx6ZqcgFMmaUZEgclKh/Gar4vuLm/gTYWOUkdakz5RerRu
	6/Aai645ndeRnMsNse32ntjtwEdFwY8C+KTYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErtGXKesWr6C9LZckppn93xzW/8h32Sf
	//cbfrTlnf2UCyP3k7ezu1LNpBP2t86az9TGxmfRwVKwHJYHlFBJQ3tPKGxGORQ+
	9N2K0phvEDcuHTgl6uSv/mDHlcTzY1PPUMKloUfAR1VyB7lvH8jAwz9S5DeXqxWC
	/zC9bu8IDHE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 978C7D9D7;
	Thu, 31 Jan 2013 10:48:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11ECAD9D3; Thu, 31 Jan 2013
 10:48:33 -0500 (EST)
In-Reply-To: <20130131132526.GA10622@unpythonic.net> (Jeff Epler's message of
 "Thu, 31 Jan 2013 07:25:27 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB432BD8-6BBD-11E2-AF58-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215118>

Jeff Epler <jepler@unpythonic.net> writes:

> I was not familiar with this behavior of 'install -d' that it tries to change
> the mode of an existing directory, but GNU coreutils 8.12.197-032bb
> certainly behaves as TJ reports.
>
> As a possible alternative, what about
>     [ -d $(DESTDIR)$(main1dir) ] || $(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
> so that $(INSTALL) is not called when the target directory exists
> already.

That can cut both ways, though.  If it exists and its permission is
too tight (say 0750), $(INSTALL) -d -m 755 ought to loosen for
others, but with the additional test, it won't be given a chance to
do so.
