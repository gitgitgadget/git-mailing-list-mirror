From: "David E. Wheeler" <david@justatheory.com>
Subject: Use git-config to Break your Config File
Date: Mon, 23 Apr 2012 19:57:19 -0700
Message-ID: <9E01F5E2-FB51-418D-B50C-EB6DC63A4F84@justatheory.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 04:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMVwV-0001af-Qn
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 04:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491Ab2DXC5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 22:57:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756317Ab2DXC5W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 22:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADBDB7CE8
	for <git@vger.kernel.org>; Mon, 23 Apr 2012 22:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from
	:content-type:content-transfer-encoding:subject:date:message-id
	:to:mime-version; s=sasl; bh=yIGsWpuKV3HCVOrEkzrDvr0CXKM=; b=Sw4
	+f7VGBcoZuqqd8/Lwcj3CMpiFdWeCpV3thDmOMXaiBOFeHy5R/KtlsVNywyJHV9j
	kYd/MzsbjseOPalckNOdIZ8iljNexKqwJuNWs71l1HQLicGB3XsGnYH5Iqelgxq9
	f3vEXsla/5hUXgD4tME4V4GWJC+49X3pRjssZWv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5BD67CE7
	for <git@vger.kernel.org>; Mon, 23 Apr 2012 22:57:21 -0400 (EDT)
Received: from [10.0.1.19] (unknown [50.137.40.254]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 657A07CE5 for
 <git@vger.kernel.org>; Mon, 23 Apr 2012 22:57:20 -0400 (EDT)
X-Mailer: Apple Mail (2.1257)
X-Pobox-Relay-ID: 3592985C-8DB9-11E1-BAF7-FC762E706CDE-76319746!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196183>

Gitsters,

I was fooling around and realized that I could assign an empty string as the name of a config section, like so:

    $ git config --rename-section my ''

This leaves the config file looking like this:

    []
        foo = goodbye

Which does not appear to be valid:

    $ git config --get '.foo'          
    fatal: bad config file line 13 in .git/config

So maybe git-config should disallow setting a section to an empty string?

Best,

David
