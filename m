From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] git-gui: Use gitattribute "encoding" for file content display
Date: Wed, 23 Jan 2008 11:28:35 +0100
Message-ID: <200801231128.36504.jnareb@gmail.com>
References: <20080123054709.GA13166@spearce.org> <7v7ii1ozly.fsf@gitster.siamese.dyndns.org> <EFF72DA9-A717-44A1-9C5C-649D08BB7E96@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 11:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHcrT-0002pi-98
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 11:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYAWK2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 05:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbYAWK2w
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 05:28:52 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:18831 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYAWK2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 05:28:51 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2090532fkz.5
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2qdPDIIGdn3vkdqOKQ4odNYbw31OX4WJ/0cRwhECako=;
        b=FxdmOcZca+cAadjYIjAMvUplQiieGSbobw53w95gBuH6Jol6cRhv3zur6i28U28b12psvlSp4AgAPhlpzhfo1QR1o3o14VX+XzFJvcMQA98mlcWjz4BQqdwM9V/hvSIlJ8G+jV+/z25VmojhTac4WbIdW/9gjRpk6vmuQzeiA8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pB5NUlaH9OSn7dIWbYgCLFN5HkjAjcFeXf/JOFXurZ/7a04q2erOJDllaAOs2zox4/BpX5b4BA3z6e9h+VIZqzOQwCSherwkzthQvlzhJlVjWlI/yegsBfqoy/enOZQBb/siHsIVpwT7UMH4lT7WHf/XdlqP9U/gqCwN5OpvjzA=
Received: by 10.82.186.5 with SMTP id j5mr16025669buf.12.1201084128841;
        Wed, 23 Jan 2008 02:28:48 -0800 (PST)
Received: from ?192.168.1.10? ( [83.8.202.8])
        by mx.google.com with ESMTPS id 13sm13625103fks.8.2008.01.23.02.28.45
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Jan 2008 02:28:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <EFF72DA9-A717-44A1-9C5C-649D08BB7E96@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71530>

On Wed. 23 Jan 2008, Steffen Prohaska wrote:
> On Jan 23, 2008, at 6:55 AM, Junio C Hamano wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>
>>> git-gui: Use gitattribute "encoding" for file content display
>>>
>>> Most folks using git-gui on internationalized files have complained
>>> that it doesn't recognize UTF-8 correctly.  In the past we have just
>>> ignored the problem and showed the file contents as binary/US-ASCII,
>>> which is wrong no matter how you look at it.
>>
>> Hmmm.
>>
>> At least for now in 1.5.4, I'd prefer the way gitk shows UTF-8
>> (if I recall correctly latin-1 or other legacy encoding, as long
>> as LANG/LC_* is given appropriately, as well) contents without
>> per-path configuration without introducing new attributes.
> 
> Shouldn't we first try harder to get things right without adding
> an attribute?  Maybe we could continue a good tradition and look
> at the content of the first: we could first look for hints in the
> file about the encoding.  XML and many text files contain such
> hints already to help editors.  For example,  Python source can
> explicitly contain the encoding [1]; and I guess there are many
> other examples.

For example LaTeX files either use inputenc package to set encoding
(e.g. \usepackage[latin2]{inputenc}) or use magic first line to
specify TCX (TeX character translation) file 
(e.g. %& -translate-file=il2-t1).

Emacs encourages to use file variables, either in the form of magic
first line, or file variables at the end of file; I think the same
is true for Vim.


I'd like then for it to be at least as configurable as diff.*.funcname 
is for diff.

> If we don't find a direct hint, we could have 
> some magic auto-detection similar to what we do for autocrlf.

We can at least try to and check for UTF-16 magic first two bytes, and 
detect if we have character which is invalid in UTF-8 (for performance 
I guess checking only beginning of file)... 

> As a fallback the user could specify a default encoding.  But only
> as a last resort, I'd use explicit attributes.

...and then falling back to fallback encoding, like gitweb does.

-- 
Jakub Narebski
Poland
