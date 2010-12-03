From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion lib
Date: Thu, 2 Dec 2010 18:07:23 -0600
Message-ID: <20101203000723.GB8438@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino>
 <20101202234053.GB3577@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Dec 03 01:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POJC1-0005CS-MR
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 01:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074Ab0LCAHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 19:07:49 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:64898 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216Ab0LCAHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 19:07:49 -0500
Received: by qyk4 with SMTP id 4so2714628qyk.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 16:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CaSVbrIIep+gxAq9VZGzXHKnkonkl1KBdrVRk6ZQtkA=;
        b=fd3xPR23g0bhCXl8HTBiDI/RDx0Lunf0qvviJ4BsfaXFelSXlzmnWqPzyLxoumqV7u
         KrGPY3676kkoj67EoyV4yJn98eMheJMhkXmE8Ta1V022jbqQUgjikz6NEaiirEcqrWqF
         vIJEJISb/mpLrZlpSv3DkgG62HAJ+GXBiZsdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fWWU3oIKO4nl9ogz3oQI0vqjL7CpO97qegVwrOkRkwWn5+WG8dU5LmE+kBbxSKbiqC
         Nfxhmg4+xDgXr/4VBZCARE7PU7BdGoXxqXLganA2UnheqLm0iPEQ8VfOmBkTkGYqgFSA
         ioxT87GHIeb1M902pYQPxUzK0UGN9y4d0ZqZk=
Received: by 10.229.96.206 with SMTP id i14mr579158qcn.268.1291334856557;
        Thu, 02 Dec 2010 16:07:36 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id l14sm757493qck.17.2010.12.02.16.07.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 16:07:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101202234053.GB3577@neumann>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162754>

SZEDER G=C3=A1bor wrote:

> Bash's programmable completion provides the COMP_WORDS array variable=
,
> which holds the individual words in the current command line.  In Bas=
h
> versions prior to v4 "words are split on shell metacharacters as the
> shell parser would separate them" (quote from bash v3.2.48's man
> page).  This behavior has changed with Bash v4, and the command line
> "is split into words as readline would split it, using COMP_WORDBREAK=
S
> as" "the set of characters that the readline library treats as word
> separators" (quote from bash v4's man page).
>
> Since COMP_WORDBREAKS contains the characters : and =3D by default, t=
his
> behavior change in Bash also affects git's completion script.  For
> example, when using Bash v4 the completion script can't provide
> possible options for a command line argument (e.g. git log
> --pretty=3D<TAB><TAB> lists files, but it should list possible log
> formats).
>=20
>=20
> I would really, _really_ like to have the above text in the commit
> message (either in yours or in Peter's), because it took me weeks to
> figure this out ;)

Sounds good.

> (I'm still wondering what Bash v3.x was doing with COMP_WORDBREAKS,
> though...)

Based on v1.5.6.4~9^2 (bash completion: Resolve git show ref:path<tab>
losing ref: portion, 2008-07-15) it seems COMP_WORDBREAKS determined
the interpretation of COMPREPLY (result of completion).  Of course it
also governed standard filename completion.

> On Thu, Dec 02, 2010 at 03:02:07PM -0600, Jonathan Nieder wrote:

>> +++ b/contrib/completion/git-completion.bash
>> @@ -327,7 +327,102 @@ __gitcomp_1 ()
[...]
>> +# This function can be used to access a tokenized list of words
>> +# on the command line:
>> +#
>> +#	__reassemble_comp_words_by_ref '=3D:'
>
> __git_reassemble_comp_words_by_ref?
[...]
>>  if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
>> +if [[ -n $ZSH_VERSION ]]; then
>
> This should be ${ZSH_VERSION-} to keep 'set -u' environments happy.

Nice catches; thanks.
