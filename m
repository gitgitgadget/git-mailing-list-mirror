From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Mon, 11 Jun 2007 09:17:47 -0700
Message-ID: <7vodjmqxck.fsf@assigned-by-dhcp.pobox.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	<11814251322779-git-send-email-hjemli@gmail.com>
	<20070610002802.GD31707@planck.djpig.de>
	<8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
	<20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
	<7vzm377cjk.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580706101414r72c45e84q2b81083f8f88ec40@mail.gmail.com>
	<20070611083406.GH955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706110347u55a944ds86f06dabce9e6435@mail.gmail.com>
	<20070611110445.GJ955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:17:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxmaX-0001nZ-DG
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 18:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXFKQRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 12:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbXFKQRu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 12:17:50 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60249 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXFKQRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 12:17:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070611161748.GEZE3133.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Jun 2007 12:17:48 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AGHn1X00E1kojtg0000000; Mon, 11 Jun 2007 12:17:48 -0400
In-Reply-To: <20070611110445.GJ955MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Mon, 11 Jun 2007 13:04:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49862>

Sven Verdoolaege <skimo@kotnet.org> writes:

>> >Why?
>> 
>> It addresses Junio's concern about ambiguity and confusion.
>
> Junio, is this really what you meant?

I think I initially misread Lars's patch and log message that
said:

    This teaches git-submodule to check module.*.path when looking for the
    config for a submodule path. If no match is found it falls back to the
    current behaviour (module.$path).

Somehow I thought that it would make it ambiguous to have
module.$name.path and module.$path when answering the question:
"given a name of a module how would you find which path to bind
it to".

But I do not think it is a problem; at least "ambiguity" worry
is unfounded.  This section, without "path = " line:

	[module "foo"]
        	url = ...

is equivalent to have "path = foo" in it.  Finding path from
module name is well defined.

The other, finding what module should go to a given path, is not
well defined.  IOW, you would not know which module you want at
the path bar/ when you have:

	[module "foo"]
        	url = ...
                path = bar
	[module "bar"]
        	url = ...

But that problem exists with or without these "module.*.path
and module.$path", so it cannot be an argument against the
definition of the fallback behaviour.
