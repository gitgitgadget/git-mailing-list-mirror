From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: remove xargs in favor of --stdin where possible
Date: Thu, 23 Apr 2009 03:25:28 -0700
Message-ID: <7v8wlrwtt3.fsf@gitster.siamese.dyndns.org>
References: <1240468281-23815-1-git-send-email-pclouds@gmail.com>
 <7vfxfzwytx.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0904230307h2d4ee691y412e9cf31e4e90c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 12:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lww9F-0000nV-4f
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 12:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbZDWKZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 06:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756138AbZDWKZj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 06:25:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbZDWKZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 06:25:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D89EACCFB;
	Thu, 23 Apr 2009 06:25:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7172BACCF9; Thu,
 23 Apr 2009 06:25:32 -0400 (EDT)
In-Reply-To: <fcaeb9bf0904230307h2d4ee691y412e9cf31e4e90c3@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu, 23 Apr 2009 20:07:19 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1512CF58-2FF1-11DE-A7E7-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117328>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> The tests may not break with your change because none of them may use
>> problematic characters (especially "\n" and '"'), but update-index --stdin
>> without -z is not suitable for reading from output from "find" without -0
>> option (on the other hand, "update-index -z --stdin" is good for reading
>> output from "find -0"; but for portability we avoid GNUism "find -0").
>
> It can't be as safe as find -0| update-index -z, but it would be
> equivalent to find|xargs, isn't it? Both separate arguments by \n.

Have you worked with pathnames with high-bit set and without
core.quotepath set to false?
