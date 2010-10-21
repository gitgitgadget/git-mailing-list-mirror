From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: bash completion broken on ubuntu 10.10?
Date: Thu, 21 Oct 2010 12:35:03 +0200
Message-ID: <4CC01757.9040706@debugon.org>
References: <20101020230409.GB1767@neumann> <20101020225018.46f7e70e@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 12:35:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8sUX-0001N2-LX
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 12:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab0JUKfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 06:35:17 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:59447 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab0JUKfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 06:35:16 -0400
Received: from [192.168.2.102] (dslb-088-071-188-252.pools.arcor-ip.net [88.71.188.252])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MdEqR-1OsAY73c7H-00IGyH; Thu, 21 Oct 2010 12:35:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <20101020225018.46f7e70e@montecarlo.grandprix.int>
X-Provags-ID: V02:K0:8YiWbMkChIaVAREE6rUhoyrIvUl/s/M3PHpbOxkIDgD
 okhakEZgKE7kkKYAUGtbAUPvLTjQ/arBzprsuiUq7y1EKrYuiI
 0zekBCMsZ7k3hxdfQyU5UVkZuX3jtj+l+H9PviDpo0yxRzfJtV
 eg9lnyYyh8avlEQhs7/utx/0hr9lOn1OlkCoqhivuKCu5jTwQ9
 EKZblkzaHC91tV5ViQT05NpVDfWnnXXbBkEkkeK6ak=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159492>

On 10/21/2010 04:50 AM, Peter van der Does wrote:
> On Thu, 21 Oct 2010 01:04:09 +0200
> SZEDER G=E1bor <szeder@ira.uka.de> wrote:
>=20
>> Hi,
>>
>> Git's bash completion script offers possible arguments to some
>> options, e.g. it lists pretty formats after 'git log --pretty=3D<TAB=
>',
>> merge tools after 'git mergetool --tool=3D<TAB>', refs after 'git co=
mmit
>> --reuse-message=3D<TAB>', etc.
>>
>> On a three day old ubuntu 10.10 install these don't work anymore; th=
e
>> completion script offers the list of files in all those cases.
>>
>> After a bit of investigation I found that when I press TAB after 'gi=
t
>> log --pretty=3D', then ${COMP_WORDS[COMP_CWORD-1]} contains '--prett=
y'
>> and ${COMP_WORDS[COMP_CWORD]} contains "=3D".  Weird.
>>
>> Then I remembered that we had some COMP_WORDBREAKS issues in the pas=
t
>> (db8a9ff, bash completion: Resolve git show ref:path<tab> losing ref=
:
>> portion, 2008-07-15)).  So I looked at my $COMP_WORDBREAKS, but didn=
't
>> see anything suspicious (it contains "'><=3D;|&(: ).  Removing the '=
=3D'
>> makes the listing after 'git log --pretty=3D' work, but breaks many
>> other things badly.
>>
>> I don't have any ideas what could possibly be wrong here (but it's t=
oo
>> late here for any bright ideas anyway...).  Could someone confirm or
>> deny this behaviour on ubuntu 10.10?
>>
>>
>> Thanks,
>> G=E1bor
>>
>=20
> My guess is that it has to do with Bash 4, the equal sign must be see=
n
> as a new word. I'm running Ubuntu 10.04 and have the same problem.
> I fixed the problem locally, I just don't know if that works on Bash =
3
> and I doubt it will work on Bash 3.
>=20
> I changed the script only for git log, not other commands yet, like=20
> git am --whitespace=3D<tab><tab>
>=20
>=20

Same problem here.

$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 10.04.1 LTS
Release:	10.04
Codename:	lucid

$ bash --version=20
GNU bash, version 4.1.5(1)-release (i486-pc-linux-gnu)

$ shopt
autocd         	off
cdable_vars    	off
cdspell        	off
checkhash      	off
checkjobs      	off
checkwinsize   	on
cmdhist        	on
compat31       	off
compat32       	off
compat40       	off
dirspell       	off
dotglob        	off
execfail       	off
expand_aliases 	on
extdebug       	off
extglob        	on
extquote       	on
failglob       	off
force_fignore  	on
globstar       	off
gnu_errfmt     	off
histappend     	on
histreedit     	off
histverify     	off
hostcomplete   	off
huponexit      	off
interactive_comments	on
lithist        	off
login_shell    	off
mailwarn       	off
no_empty_cmd_completion	off
nocaseglob     	off
nocasematch    	off
nullglob       	off
progcomp       	on
promptvars     	on
restricted_shell	off
shift_verbose  	off
sourcepath     	on
xpg_echo       	off

-Mathias
