From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: ks/precompute-completion
Date: Thu, 12 Nov 2009 23:12:13 -0800
Message-ID: <4AFD06CD.7090003@gmail.com>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org> <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com> <20091111220832.GA31620@progeny.tock> <4AFCFF50.5080401@gmail.com> <20091113070652.GA3907@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 08:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8qSN-0006pJ-3e
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 08:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZKMHUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 02:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbZKMHUT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 02:20:19 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:64952 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbZKMHUS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 02:20:18 -0500
Received: by yxe17 with SMTP id 17so2701403yxe.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 23:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=dLQBRsT3JdJWwp3y/em+55jaQvQYNVzsjcmnwk/4NR8=;
        b=EeOZhyQ265BXdxywqtYQf/ayrllnUSgVX52laIpYfQVmEu32UWnOHuZmwLAkXxk1I3
         NWpcbTN5c/55vgOUIX1bQbviGDv2EqCs5Q04D5MgVUilrhKfl/QYroTAC/rQv2rC70M8
         tkcIwizFEENwYAS5EJFpv/h2Nv13Z0cC387HE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RXnGGITs//6sT+j3RAfz6aqXMQnria3yRr1nByE+CkdhpNgw5eRgloHaRH9bx7XQhp
         XqVVkZ7CQQnOarFM71YVhWoQjp42Hft4VhB7kt7OxbE64iqQYx2bOsmvRsbwYHX9IA9S
         Yqu2+TFGw2qZubTVPK5OdVxycW3sRPPpnHUeY=
Received: by 10.101.184.5 with SMTP id l5mr4249110anp.88.1258096336806;
        Thu, 12 Nov 2009 23:12:16 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 35sm316748yxh.69.2009.11.12.23.12.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 23:12:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <20091113070652.GA3907@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132819>

Jonathan Nieder wrote:
> Stephen Boyd wrote:
>> I'm confused. Shouldn't your distro take care of updating the
>> completion for you? And wouldn't update-git-completion be more
>> suited as part of a makefile if it was needed at all?
>
> The problem is that I have git commands the distro did not install in
> my $PATH.  For example, I currently have git-new-workdir in ~/bin, and
> once I bzr-fastexport works a little better, I will install git-bzr.
>
> Even without such commands, in many distributions the completion
> should not be one size fits all, since git-svn (for example) belongs
> to a different package

Ah ok. I think this proves even more that pregenerating the completion 
is a bad idea. With dynamic population we don't have these problems and 
it only takes 250ms more to load on a P3 700Mhz.

Maybe we should try and speedup 'git help -a' and 'git merge -s help' 
instead? Perhaps options for the command/porcelain lists and available 
strategies formatted for script consumption? I doubt it will be as fast 
as compiling, but every bit helps apparently.

Side Note: Running git merge -s help outside a git repository fails, so 
caching of the merge strategies isn't very effective.
