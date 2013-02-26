From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: gc does not clean up after itself when not enough disk space
Date: Tue, 26 Feb 2013 21:31:08 +0100
Message-ID: <512D1B8C.9070506@web.de>
References: <512CD689.4050705@gmail.com> <512CD703.4080302@gmail.com> <7v1uc3njnf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "jones.noamle" <lenoam@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:31:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UARBc-0002VW-8C
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab3BZUbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:31:15 -0500
Received: from mout.web.de ([212.227.17.11]:65501 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab3BZUbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:31:14 -0500
Received: from [192.168.178.41] ([79.193.92.94]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MgwdY-1UWUJD15DU-00MR22; Tue, 26 Feb 2013 21:31:11
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7v1uc3njnf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:B2nT+00rnmFYUhqLUI+MYxi7MtDDqt94AwSkBY4O60J
 nrcz3pVDsDrmBUXcN7AXEiKVEAQmIC2HjB3boPZHF9zI8NoMpY
 6+3kZAgm9SBEFuKJvIgmDAi3NFPrYYLr/Cwg+EXOrAPqPbkAJx
 yKlSOewA5EFspiWvTknIF2hhptSTCSyt6rUGoshQOsIKEHz6Pr
 S0Xj1u/UCveOFklbhjdoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217178>

Am 26.02.2013 17:07, schrieb Junio C Hamano:
> "jones.noamle" <lenoam@gmail.com> writes:
> 
>> # git gc
>> Counting objects: 44626, done.
>> Delta compression using up to 8 threads.
>> Compressing objects: 100% (7756/7756), done.
>> fatal: sha1 file '.git/objects/pack/tmp_pack_uJ0E5b' write error: No
>> space left on device
> 
> In general when we encounter an unexpected error, we tend to try
> leaving things as they are so that we can help diagnosing the
> failure. But when you ran out of disk space I would agree that it
> may be sensible to remove a temporary file we didn't manage to write
> out in full.

Ack. I just recently had to do

   git gc || rm -f .git/objects/*/tmp_*

as workaround in the nightly housekeeping script on our CI server.
