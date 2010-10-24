From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH v2] make pack-objects a bit more resilient to repo corruption
Date: Sat, 23 Oct 2010 22:26:46 -0400
Message-ID: <30FC97D9-D9F2-4A08-8E69-4556DE204AA6@adacore.com>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home> <20101022144600.GA5554@sigill.intra.peff.net> <alpine.LFD.2.00.1010221427390.2764@xanadu.home> <alpine.LFD.2.00.1010221606550.2764@xanadu.home> <AANLkTimy-ihrF1syWYe3T4W6-UHzCaj5Jud5rdFmv3D5@mail.gmail.com> <alpine.LFD.2.00.1010221714450.2764@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Oct 24 04:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9qP4-00034O-SZ
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 04:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab0JXCdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 22:33:37 -0400
Received: from rock.gnat.com ([205.232.38.15]:32982 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab0JXCdh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 22:33:37 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Oct 2010 22:33:36 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id B39BD2BAC0D;
	Sat, 23 Oct 2010 22:26:47 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id K90PfX06ZkTj; Sat, 23 Oct 2010 22:26:47 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 64E6A2BAC0C;
	Sat, 23 Oct 2010 22:26:47 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1010221714450.2764@xanadu.home>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159835>


On Oct 22, 2010, at 17:19, Nicolas Pitre wrote:

>> On Fri, Oct 22, 2010 at 13:26, Nicolas Pitre <nico@fluxnic.net> wrote:
>>> +                               static int warned = 0;
>>> +                               if (!warned++)
>>> +                                       warning("object %s cannot be read",
>>> +                                               sha1_to_hex(src_entry->idx.sha1));
>> 
>> How does this handle multiple missing objects? Will it only warn for
>> the first one?
> 
> Yes, only the first one, so you have a bone to chase if that ever 
> happens to you.  And that's good enough IMHO.  Trying to warn for every 
> missing object would require extra storage per object to remember if any 
> particular object was warned for already, which is I think overkill for 
> an extremely unlikely event.  Comprehensive reporting is the job of 
> fsck.

Maybe add a ", run git fsck" to the message. Will still comfortably fit a line.

  -Geert