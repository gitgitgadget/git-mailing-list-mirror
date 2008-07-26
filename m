From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Sat, 26 Jul 2008 18:07:45 +0200
Message-ID: <65E5BA28-DAB0-4731-A6DA-DBE646367FBF@zib.de>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261515290.26810@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 18:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMmLP-0004wh-9A
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 18:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbYGZQHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbYGZQHh
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 12:07:37 -0400
Received: from mailer.zib.de ([130.73.108.11]:43410 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYGZQHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 12:07:37 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6QG7Mtx027724;
	Sat, 26 Jul 2008 18:07:27 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83e58.pool.einsundeins.de [77.184.62.88])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6QG7LEQ018593
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 26 Jul 2008 18:07:22 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807261515290.26810@eeepc-johanness>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90252>


On Jul 26, 2008, at 3:17 PM, Johannes Schindelin wrote:

> On Sat, 26 Jul 2008, Steffen Prohaska wrote:
>
>> -#define main(c,v) main(int argc, const char **argv) \
>> +#define main(c,v) dummy_decl_mingw_main(); \
>
> What is this dummy_*() statement supposed to do?


Avoid compile errors.  The original statement is

    int main( ...

But we want

    static int mingw_main( ...

So we need to first get rid of the original int, before
we can start the static decl.  We get rid by completing
the original int with the dummy_decl_mingw_main(); to a
full function decl.

	Steffen
