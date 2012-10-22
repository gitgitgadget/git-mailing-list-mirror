From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Mon, 22 Oct 2012 15:46:08 +0200
Message-ID: <50854E20.1040303@viscovery.net>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com> <5084E931.3010809@viscovery.net> <CAMP44s2XDkLhKkqvxnGH+U5X=42dXU1550xVQvyQk=WD2p0c6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:46:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQIKw-0005Oe-8m
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 15:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab2JVNqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 09:46:16 -0400
Received: from so.liwest.at ([212.33.55.24]:41435 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab2JVNqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 09:46:14 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TQIKX-0002Hq-4B; Mon, 22 Oct 2012 15:46:09 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D099E1660F;
	Mon, 22 Oct 2012 15:46:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CAMP44s2XDkLhKkqvxnGH+U5X=42dXU1550xVQvyQk=WD2p0c6Q@mail.gmail.com>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208187>

Am 10/22/2012 13:50, schrieb Felipe Contreras:
> On Mon, Oct 22, 2012 at 8:35 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Another thought: In your use-case, isn't it so that it would be an error
>> that the process exited for whatever reason? I.e., even if it exited with
>> code 0 ("success"), it would be an error because it violated the protocol?
> 
> How is that violating the protocol?

Because the helper stops talking too early. But as I said, I actually
don't know the protocol.

I was just infering what I saw in transport-helper.c: get_helper() dup's
the output of the helper process and stores it in data->out (after
fdopen()ing on it). (The original file descriptor is handed over to
fast-import or fast-export.)

Actually, I didn't find a spot where data->out was used except to fclose()
it. But I take it that there is a reason that it exists and infer that
further output from the helper is expected by something after fast-import
or fast-export have exited.

But I may be completely off...

-- Hannes
