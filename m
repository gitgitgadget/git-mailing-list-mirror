From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: [PATCH 2/2] New send-email option smtpserveroptions.
Date: Sat, 04 Sep 2010 18:39:51 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C827657.3000508@obry.net>
References: <1283616372-3340-1-git-send-email-pascal@obry.net> <1283616372-3340-3-git-send-email-pascal@obry.net> <7v4oe5xyxd.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 18:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrvmH-0006Fr-6z
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab0IDQjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:39:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59018 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab0IDQje (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:39:34 -0400
Received: by wwj40 with SMTP id 40so4283782wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=O7eUzPmcGs8n7+gPOzYRYCJ71cAWzyAoQFeFLGWSZSk=;
        b=AMp2vLDgfX5AYN4nw3h4MMNKZlvN985EuJ9A+x/pp50uaUF1VR3C+Dd01wsqaK8w0O
         LUStanwUwY4PzsoKYAdc1wNiAZQjK2jG8yjr/q8CaovqpM42W/35HWhgIvrCDHk/guMs
         qroR6cQNCWePpZ/s5dTC3htH2WNBO26Ewdjt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        b=TXLcCQpIp3WpFVqeWU+h02KfYm1vYE9W/Xx4ni/9WuI/R7YdExGmzpYAfbzBHf95CA
         +QKiB0ioPemCOiqQsWBjT0vKLFClVsFwmQgfigHpVrQK8oerHAfZGFJjoYQgFqzIDQGc
         P9ALEzcIRRzQhB/0tMm3GfagLdcrPSKqAH+wk=
Received: by 10.216.6.195 with SMTP id 45mr1267054wen.86.1283618372059;
        Sat, 04 Sep 2010 09:39:32 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id p82sm2090802weq.27.2010.09.04.09.39.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 09:39:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7v4oe5xyxd.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155340>

Junio,

>> +    --smtp-server-options   <int>  * Outgoing SMTP server options to use.
> 
> Is it really an int?

Oups! Fixed.

>> +	unshift (@sendmail_parameters, $smtp_server_options)
>> +	    if (defined $smtp_server_options);
>> +
> 
> I suspect this would not work, unless you are aiming to add just a
> singular $smtp_server_option, as the actual program invocation looks like
> this later in the program:
> 
> 	} elsif ($smtp_server =~ m#^/#) {
> 		my $pid = open my $sm, '|-';
> 		defined $pid or die $!;
> 		if (!$pid) {
> 			exec($smtp_server, @sendmail_parameters) or die $!;
> 		}
> 		print $sm "$header\n$message";
> 
> Somebody in the code before this unshift needs to split the single string
> in $smtp_server_options into multiple parameters, or better yet, it needs
> to accept more than one --smtp-server-option=foo --smtp-server-option=bar
> and accumulate them in @smtp_server_options.

For sure this is above my expertise in Perl. As I said I have never
worked with Perl. If someone gives me some pointers I can give it a try
otherwise I surrender :)

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
