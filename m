From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 12:23:52 +0200
Message-ID: <4BE7DEB8.5000900@viscovery.net>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org> <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 12:24:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQ9f-00087C-MW
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 12:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab0EJKX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 06:23:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33142 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab0EJKX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 06:23:57 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OBQ9R-0007Va-HM; Mon, 10 May 2010 12:23:53 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3A5D61660F;
	Mon, 10 May 2010 12:23:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146790>

Am 5/10/2010 11:09, schrieb Sverre Rabbelier:
> On Mon, May 10, 2010 at 09:19, Johannes Sixt <j6t@kdbg.org> wrote:
>> Use 'grep' to check for expected output.
> 
> Don't we do this ('test_cmp' on expected output) in many other places
> as well? Why is this different?

This is really only special because the test_cmp looked at the stderr of a
test_must_fail command. The old code was:

	test_must_fail git ls-remote refs*master >actual 2>&1 &&
	test_cmp exp actual

With bash, 'actual' contained:

  ++ git ls-remote 'refs*master'
  fatal: 'refs*master' does not appear to be a git repository
  fatal: The remote end hung up unexpectedly
  ++ test 128 -gt 0 -a 128 -le 129 -o 128 -gt 192

i.e., there were command traces in the file.

-- Hannes
