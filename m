From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 22:28:56 +0100
Message-ID: <0e50c39792144f5cb18260009384b4d0@212.159.54.234>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <201004142110.36453.jnareb@gmail.com> <80f140cdddc016f9b4608d79f1bc3722@212.159.54.234> <201004142316.07947.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:29:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2A99-0004II-Qk
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab0DNV27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 17:28:59 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:41467 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756012Ab0DNV27 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 17:28:59 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id B6AED819C74A;
	Wed, 14 Apr 2010 22:28:50 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 4301020CFB5;
	Wed, 14 Apr 2010 22:28:57 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DGmmeIoEc7f7; Wed, 14 Apr 2010 22:28:56 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C2CCB20CEFC;
	Wed, 14 Apr 2010 22:28:56 +0100 (BST)
In-Reply-To: <201004142316.07947.jnareb@gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144920>

On Wed, 14 Apr 2010 23:16:06 +0200, Jakub Narebski <jnareb@gmail.com>
wrote:
> On Wed,  14 Apr 2010, Julian Phillips wrote:
>> On Wed, 14 Apr 2010 21:10:35 +0200, Jakub Narebski <jnareb@gmail.com>
>> wrote:
>> Anyway, I have already converted blame to use the library for both
>> --porcelain and --incremental output, so it'll be in the next version
of
>> the patch series.  So you can try before you buy ...
> 
> Nice.
> 
> How did you managed to work with a bit non-standard rules of --porcelain
> format, namely maybe-quoting of filenames, and that not all lines
conform
> to "<header> SP <value> LF" syntax: group definition begins with SHA-1,
> and contents is indented with TAB?

I had to extend the output API for quoting rules.  There are now
qstr/qstrf output functions that call different backend functions.  The
normal output then applies git quoting rules to the q versions only,
whereas the JSON output treats them both the same.

For the rest of it, only the actual data is going through the output_str
etc functions the rest is using output_token that is ignored by the JSON
backend.  I actually started converting blame twice - the first time I
added an API function that allowed telling the normal output how to format
values, but I decided that I wanted to apply grouping to the structured
output, so that e.g. the author and committer information were two objects
with name, mail, date and tz members so I never finished the first attempt.

-- 
Julian
